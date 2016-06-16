require "spec_helper"

describe HighVoltage::PageCollector do
  before :example do
    # For whatever reason, the HTML template handler is not available at
    # this point, causing the ".html" file extension to be unrecognized
    # by our code.  Thus we plug the ERB handler in its place.
    ActionView::Template.register_template_handler(:html,
      ActionView::Template.handler_for_extension(:erb))

    # Also, pretend we have the Haml gem installed...
    ActionView::Template.register_template_handler(:haml,
      ActionView::Template.handler_for_extension(:raw))
  end

  it "produces an array of all page_ids under pages/" do
    expect(HighVoltage.page_ids).to eq [
      "also_dir/also_nested",
      "also_exists",
      "also_exists_but_references_nonexistent_partial",
      "bare_haml",
      "dir/nested",
      "exists",
      "exists_but_references_nonexistent_partial",
      "rot13",
      "static_text.txt",
      "text.txt",
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

  it "excludes partials from page_ids" do
    expect(HighVoltage.page_ids).not_to include("_partial")
  end

  private

  def with_content_path(path)
    original_content_path = HighVoltage.content_path
    HighVoltage.content_path = path

    yield

    HighVoltage.content_path = original_content_path
  end
end
