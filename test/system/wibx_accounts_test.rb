require "application_system_test_case"

class WibxAccountsTest < ApplicationSystemTestCase
  setup do
    @wibx_account = wibx_accounts(:one)
  end

  test "visiting the index" do
    visit wibx_accounts_url
    assert_selector "h1", text: "Wibx accounts"
  end

  test "should create wibx account" do
    visit wibx_accounts_url
    click_on "New wibx account"

    fill_in "Email", with: @wibx_account.email
    fill_in "Password", with: @wibx_account.password
    click_on "Create Wibx account"

    assert_text "Wibx account was successfully created"
    click_on "Back"
  end

  test "should update Wibx account" do
    visit wibx_account_url(@wibx_account)
    click_on "Edit this wibx account", match: :first

    fill_in "Email", with: @wibx_account.email
    fill_in "Password", with: @wibx_account.password
    click_on "Update Wibx account"

    assert_text "Wibx account was successfully updated"
    click_on "Back"
  end

  test "should destroy Wibx account" do
    visit wibx_account_url(@wibx_account)
    click_on "Destroy this wibx account", match: :first

    assert_text "Wibx account was successfully destroyed"
  end
end
