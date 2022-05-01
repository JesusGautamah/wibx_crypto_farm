require "test_helper"

class WibxAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wibx_account = wibx_accounts(:one)
  end

  test "should get index" do
    get wibx_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_wibx_account_url
    assert_response :success
  end

  test "should create wibx_account" do
    assert_difference("WibxAccount.count") do
      post wibx_accounts_url, params: { wibx_account: { email: @wibx_account.email, password: @wibx_account.password } }
    end

    assert_redirected_to wibx_account_url(WibxAccount.last)
  end

  test "should show wibx_account" do
    get wibx_account_url(@wibx_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_wibx_account_url(@wibx_account)
    assert_response :success
  end

  test "should update wibx_account" do
    patch wibx_account_url(@wibx_account), params: { wibx_account: { email: @wibx_account.email, password: @wibx_account.password } }
    assert_redirected_to wibx_account_url(@wibx_account)
  end

  test "should destroy wibx_account" do
    assert_difference("WibxAccount.count", -1) do
      delete wibx_account_url(@wibx_account)
    end

    assert_redirected_to wibx_accounts_url
  end
end
