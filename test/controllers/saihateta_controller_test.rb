require 'test_helper'

class SaihatetaControllerTest < ActionDispatch::IntegrationTest
  test "should get 1" do
    get saihateta_1_url
    assert_response :success
  end

end
