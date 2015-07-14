# encoding: utf-8

require "spec_helper"

describe HighVoltage::PageFinder do
  it "produces the name of an existing template" do
    expect(find("existing")).to eq "pages/existing"
  end

  it "produces the name of a nested template" do
    expect(find("dir/nested")).to eq "pages/dir/nested"
  end

  it "uses a custom content path" do
    with_content_path("other_pages/") do
      expect(find("also_exists")).to eq "other_pages/also_exists"
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

  it "removes invalid characters from the page_id" do
    expect(find("b\\a…d√")).to eq "pages/bad"
  end

  context "sanitized page_id" do
    it "throws an exception if the page_id is empty" do
      expect { find("\\…√") }.to raise_error HighVoltage::InvalidPageIdError
    end

    it "throws an exception if the page_id is just a file extension" do
      expect { find("\\√.zip") }.to raise_error HighVoltage::InvalidPageIdError
    end
  end

  it "throws an exception if the path is empty" do
    expect { find("關於我們/合作伙伴") }.to raise_error HighVoltage::InvalidPageIdError
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
