require 'test_helper'

class TopPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get top_pages_index_url
    assert_response :success
  end

  test "should get new" do
    get top_pages_new_url
    assert_response :success
  end

end
