require "spec_helper"

feature "view page" do
  scenario "successfully" do
    visit page_path(id: "about")

    expect(page).to have_content "About Us"
  end
end
