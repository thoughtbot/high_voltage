# encoding: utf-8

require "spec_helper"

describe HighVoltage::PageFinder do
  it "produces the name of an existing template" do
    expect(find("existing")).to eq "pages/existing"
  end

  it "produces the name of a nested template" do
    expect(find("dir/nested")).to eq "pages/dir/nested"
  end

  it "produces the name of a dotfile" do
    expect(find(".file")).to eq "pages/.file"
  end

  it "supports non-ASCII characters" do
    expect(find("résumé")).to eq "pages/résumé"
  end

  it "uses a custom content path" do
    with_content_path("other_pages/") do
      expect(find("also_exists")).to eq "other_pages/also_exists"
    end
  end

  it "allows the trailing slash to be omitted from the content path" do
    with_content_path("forgot_slash") do
      expect(find("thing")).to eq "forgot_slash/thing"
    end
  end

  it "exposes the content path" do
    with_content_path("another_thing/") do
      expect(page_finder.content_path).to eq "another_thing/"
    end
  end

  it "provides the page_id" do
    subclass = Class.new(HighVoltage::PageFinder) do
      def page_name
        "the page is #{page_id}"
      end
    end

    expect(subclass.new("sweet page").page_name).to eq "the page is sweet page"
  end

  context "bad page_id" do
    it "throws an exception if page_id resolves to empty" do
      expect { find("") }.to raise_error HighVoltage::InvalidPageIdError
      expect { find("/") }.to raise_error HighVoltage::InvalidPageIdError
      expect { find(".") }.to raise_error HighVoltage::InvalidPageIdError
      expect { find("\\.") }.to raise_error HighVoltage::InvalidPageIdError
      expect { find("/\\.") }.to raise_error HighVoltage::InvalidPageIdError
      expect { find("dummy/..") }.to raise_error HighVoltage::InvalidPageIdError
    end

    it "throws an exception if page_id resolves to outside the content path" do
      expect { find("..") }.to raise_error HighVoltage::InvalidPageIdError
      expect { find("\\..") }.to raise_error HighVoltage::InvalidPageIdError
      expect { find("/\\..") }.to raise_error HighVoltage::InvalidPageIdError
      expect { find("../secret") }.
        to raise_error HighVoltage::InvalidPageIdError
      expect { find("\\../secret") }.
        to raise_error HighVoltage::InvalidPageIdError
      expect { find("/\\../secret") }.
        to raise_error HighVoltage::InvalidPageIdError
      expect { find("dummy/../../secret") }.
        to raise_error HighVoltage::InvalidPageIdError
    end
  end

  private

  def find(page_id)
    page_finder(page_id).find
  end

  def page_finder(page_id = "whatever")
    HighVoltage::PageFinder.new(page_id)
  end

  def with_content_path(path)
    original_content_path = HighVoltage.content_path
    HighVoltage.content_path = path

    yield

    HighVoltage.content_path = original_content_path
  end
end
