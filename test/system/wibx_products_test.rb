require "application_system_test_case"

class WibxProductsTest < ApplicationSystemTestCase
  setup do
    @wibx_product = wibx_products(:one)
  end

  test "visiting the index" do
    visit wibx_products_url
    assert_selector "h1", text: "Wibx products"
  end

  test "should create wibx product" do
    visit wibx_products_url
    click_on "New wibx product"

    fill_in "Facebook gain", with: @wibx_product.facebook_gain
    fill_in "Facebook link", with: @wibx_product.facebook_link
    fill_in "Facebook requests", with: @wibx_product.facebook_requests
    fill_in "Status", with: @wibx_product.status
    fill_in "Telegram gain", with: @wibx_product.telegram_gain
    fill_in "Telegram link", with: @wibx_product.telegram_link
    fill_in "Telegram requests", with: @wibx_product.telegram_requests
    fill_in "Title", with: @wibx_product.title
    fill_in "Total user product gain", with: @wibx_product.total_user_product_gain
    fill_in "User facebook gain", with: @wibx_product.user_facebook_gain
    fill_in "User telegram gain", with: @wibx_product.user_telegram_gain
    fill_in "User whatsapp gain", with: @wibx_product.user_whatsapp_gain
    fill_in "Whatsapp gain", with: @wibx_product.whatsapp_gain
    fill_in "Whatsapp link", with: @wibx_product.whatsapp_link
    fill_in "Whatsapp requests", with: @wibx_product.whatsapp_requests
    click_on "Create Wibx product"

    assert_text "Wibx product was successfully created"
    click_on "Back"
  end

  test "should update Wibx product" do
    visit wibx_product_url(@wibx_product)
    click_on "Edit this wibx product", match: :first

    fill_in "Facebook gain", with: @wibx_product.facebook_gain
    fill_in "Facebook link", with: @wibx_product.facebook_link
    fill_in "Facebook requests", with: @wibx_product.facebook_requests
    fill_in "Status", with: @wibx_product.status
    fill_in "Telegram gain", with: @wibx_product.telegram_gain
    fill_in "Telegram link", with: @wibx_product.telegram_link
    fill_in "Telegram requests", with: @wibx_product.telegram_requests
    fill_in "Title", with: @wibx_product.title
    fill_in "Total user product gain", with: @wibx_product.total_user_product_gain
    fill_in "User facebook gain", with: @wibx_product.user_facebook_gain
    fill_in "User telegram gain", with: @wibx_product.user_telegram_gain
    fill_in "User whatsapp gain", with: @wibx_product.user_whatsapp_gain
    fill_in "Whatsapp gain", with: @wibx_product.whatsapp_gain
    fill_in "Whatsapp link", with: @wibx_product.whatsapp_link
    fill_in "Whatsapp requests", with: @wibx_product.whatsapp_requests
    click_on "Update Wibx product"

    assert_text "Wibx product was successfully updated"
    click_on "Back"
  end

  test "should destroy Wibx product" do
    visit wibx_product_url(@wibx_product)
    click_on "Destroy this wibx product", match: :first

    assert_text "Wibx product was successfully destroyed"
  end
end
