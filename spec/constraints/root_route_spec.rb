require "spec_helper"

describe HighVoltage::Constraints::RootRoute, ".matches?" do
  it "returns true when the view file exists" do
    request = double(path: 'index')
    file_path = Rails.root.join("app", "views", "pages", "index.html*").to_s

    allow(Dir).to receive(:glob).with(file_path).and_return(["about.html.erb"])

    result = HighVoltage::Constraints::RootRoute.matches?(request)

    expect(result).to be true
  end

  it "returns true when the view file exists and url ends with .html" do
    request = double(path: "index.html")
    file_path = Rails.root.join("app", "views", "pages", "index.html*").to_s

    allow(Dir).to receive(:glob).with(file_path).and_return(["about.html.erb"])

    result = HighVoltage::Constraints::RootRoute.matches?(request)

    expect(result).to be true
  end

  it "returns false when the view files does not exist" do
    request = double(path: 'index')
    file_path = Rails.root.join("app", "views", "pages", "index", ".html*").to_s

    allow(File).to receive(:glob).with(file_path).and_return([])

    result = HighVoltage::Constraints::RootRoute.matches?(request)

    expect(result).to be false
  end
end
