require "spec_helper"

feature "current page helper" do
  scenario "is available in view" do
    visit page_path(id: "current_page_helper")

    expect(page).to have_content "Current Page: pages/current_page_helper"
  end
end
