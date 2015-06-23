require "spec_helper"

describe HighVoltage::Page do
  it "produces the id for a page" do
    page = page(full_file_path("exists.html.erb"))

    expect(page.id).to eq "exists"
  end

  it "produces the id for a page in a subdirectory" do
    page = page(full_file_path("dir/nested.html.erb"))

    expect(page.id).to eq "dir/nested"
  end

  it "is valid for a page" do
    page = page(full_file_path("exists.html.erb"))

    expect(page).to be_valid
  end

  it "is valid for a page in a subdirectory" do
    page = page(full_file_path("dir/nested.html.erb"))

    expect(page).to be_valid
  end

  it "is invalid for a directory" do
    page = page(full_file_path("dir"))

    expect(page).to_not be_valid
  end

  it "is invalid for a partial" do
    page = page(full_file_path("_partial.html.erb"))

    expect(page).to_not be_valid
  end

  it "is invalid for a non-existent page" do
    page = page(full_file_path("nonexistent.html.erb"))

    expect(page).to_not be_valid
  end

  it "is invalid for a text page" do
    page = page(full_file_path("text.txt.erb"))

    expect(page).to_not be_valid
  end

  private

  def full_content_path
    HighVoltage.full_path.to_s
  end

  def page(file_path)
    HighVoltage::Page.new(full_content_path, file_path)
  end

  def full_file_path(file_path)
    "#{full_content_path}#{file_path}"
  end
end
