require "application_system_test_case"

class FaceAccountsTest < ApplicationSystemTestCase
  setup do
    @face_account = face_accounts(:one)
  end

  test "visiting the index" do
    visit face_accounts_url
    assert_selector "h1", text: "Face accounts"
  end

  test "should create face account" do
    visit face_accounts_url
    click_on "New face account"

    fill_in "Email", with: @face_account.email
    fill_in "Password", with: @face_account.password
    click_on "Create Face account"

    assert_text "Face account was successfully created"
    click_on "Back"
  end

  test "should update Face account" do
    visit face_account_url(@face_account)
    click_on "Edit this face account", match: :first

    fill_in "Email", with: @face_account.email
    fill_in "Password", with: @face_account.password
    click_on "Update Face account"

    assert_text "Face account was successfully updated"
    click_on "Back"
  end

  test "should destroy Face account" do
    visit face_account_url(@face_account)
    click_on "Destroy this face account", match: :first

    assert_text "Face account was successfully destroyed"
  end
end
