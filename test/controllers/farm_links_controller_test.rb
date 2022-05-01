require "test_helper"

class FarmLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @farm_link = farm_links(:one)
  end

  test "should get index" do
    get farm_links_url
    assert_response :success
  end

  test "should get new" do
    get new_farm_link_url
    assert_response :success
  end

  test "should create farm_link" do
    assert_difference("FarmLink.count") do
      post farm_links_url, params: { farm_link: { href: @farm_link.href } }
    end

    assert_redirected_to farm_link_url(FarmLink.last)
  end

  test "should show farm_link" do
    get farm_link_url(@farm_link)
    assert_response :success
  end

  test "should get edit" do
    get edit_farm_link_url(@farm_link)
    assert_response :success
  end

  test "should update farm_link" do
    patch farm_link_url(@farm_link), params: { farm_link: { href: @farm_link.href } }
    assert_redirected_to farm_link_url(@farm_link)
  end

  test "should destroy farm_link" do
    assert_difference("FarmLink.count", -1) do
      delete farm_link_url(@farm_link)
    end

    assert_redirected_to farm_links_url
  end
end
