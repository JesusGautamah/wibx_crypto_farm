require "test_helper"

class WibxProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wibx_product = wibx_products(:one)
  end

  test "should get index" do
    get wibx_products_url
    assert_response :success
  end

  test "should get new" do
    get new_wibx_product_url
    assert_response :success
  end

  test "should create wibx_product" do
    assert_difference("WibxProduct.count") do
      post wibx_products_url, params: { wibx_product: { facebook_gain: @wibx_product.facebook_gain, facebook_link: @wibx_product.facebook_link, facebook_requests: @wibx_product.facebook_requests, status: @wibx_product.status, telegram_gain: @wibx_product.telegram_gain, telegram_link: @wibx_product.telegram_link, telegram_requests: @wibx_product.telegram_requests, title: @wibx_product.title, total_user_product_gain: @wibx_product.total_user_product_gain, user_facebook_gain: @wibx_product.user_facebook_gain, user_telegram_gain: @wibx_product.user_telegram_gain, user_whatsapp_gain: @wibx_product.user_whatsapp_gain, whatsapp_gain: @wibx_product.whatsapp_gain, whatsapp_link: @wibx_product.whatsapp_link, whatsapp_requests: @wibx_product.whatsapp_requests } }
    end

    assert_redirected_to wibx_product_url(WibxProduct.last)
  end

  test "should show wibx_product" do
    get wibx_product_url(@wibx_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_wibx_product_url(@wibx_product)
    assert_response :success
  end

  test "should update wibx_product" do
    patch wibx_product_url(@wibx_product), params: { wibx_product: { facebook_gain: @wibx_product.facebook_gain, facebook_link: @wibx_product.facebook_link, facebook_requests: @wibx_product.facebook_requests, status: @wibx_product.status, telegram_gain: @wibx_product.telegram_gain, telegram_link: @wibx_product.telegram_link, telegram_requests: @wibx_product.telegram_requests, title: @wibx_product.title, total_user_product_gain: @wibx_product.total_user_product_gain, user_facebook_gain: @wibx_product.user_facebook_gain, user_telegram_gain: @wibx_product.user_telegram_gain, user_whatsapp_gain: @wibx_product.user_whatsapp_gain, whatsapp_gain: @wibx_product.whatsapp_gain, whatsapp_link: @wibx_product.whatsapp_link, whatsapp_requests: @wibx_product.whatsapp_requests } }
    assert_redirected_to wibx_product_url(@wibx_product)
  end

  test "should destroy wibx_product" do
    assert_difference("WibxProduct.count", -1) do
      delete wibx_product_url(@wibx_product)
    end

    assert_redirected_to wibx_products_url
  end
end
