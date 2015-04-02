require "spec_helper"

describe HighVoltage::PageCollector do
  it "produces an array of all page_ids under pages/" do
    expect(HighVoltage.page_ids).to eq [
      "also_dir/also_nested",
      "also_exists",
      "also_exists_but_references_nonexistent_partial",
      "dir/nested",
      "exists",
      "exists_but_references_nonexistent_partial",
      "rot13"
    ]
  end

  it "produces an array of all page_ids under other_pages/" do
    with_content_path("other_pages/") do
      expect(HighVoltage.page_ids).to eq [
        "also_dir/also_nested",
        "also_exists",
        "also_exists_but_references_nonexistent_partial",
      ]
    end
  end

  private

  def with_content_path(path)
    original_content_path = HighVoltage.content_path
    HighVoltage.content_path = path

    yield

    HighVoltage.content_path = original_content_path
  end
end
