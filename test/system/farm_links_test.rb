require "application_system_test_case"

class FarmLinksTest < ApplicationSystemTestCase
  setup do
    @farm_link = farm_links(:one)
  end

  test "visiting the index" do
    visit farm_links_url
    assert_selector "h1", text: "Farm links"
  end

  test "should create farm link" do
    visit farm_links_url
    click_on "New farm link"

    fill_in "Href", with: @farm_link.href
    click_on "Create Farm link"

    assert_text "Farm link was successfully created"
    click_on "Back"
  end

  test "should update Farm link" do
    visit farm_link_url(@farm_link)
    click_on "Edit this farm link", match: :first

    fill_in "Href", with: @farm_link.href
    click_on "Update Farm link"

    assert_text "Farm link was successfully updated"
    click_on "Back"
  end

  test "should destroy Farm link" do
    visit farm_link_url(@farm_link)
    click_on "Destroy this farm link", match: :first

    assert_text "Farm link was successfully destroyed"
  end
end
