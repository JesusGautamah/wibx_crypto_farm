require "test_helper"

class FaceAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @face_account = face_accounts(:one)
  end

  test "should get index" do
    get face_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_face_account_url
    assert_response :success
  end

  test "should create face_account" do
    assert_difference("FaceAccount.count") do
      post face_accounts_url, params: { face_account: { email: @face_account.email, password: @face_account.password } }
    end

    assert_redirected_to face_account_url(FaceAccount.last)
  end

  test "should show face_account" do
    get face_account_url(@face_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_face_account_url(@face_account)
    assert_response :success
  end

  test "should update face_account" do
    patch face_account_url(@face_account), params: { face_account: { email: @face_account.email, password: @face_account.password } }
    assert_redirected_to face_account_url(@face_account)
  end

  test "should destroy face_account" do
    assert_difference("FaceAccount.count", -1) do
      delete face_account_url(@face_account)
    end

    assert_redirected_to face_accounts_url
  end
end
