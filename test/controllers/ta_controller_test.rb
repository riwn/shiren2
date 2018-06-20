require 'test_helper'

class TaControllerTest < ActionDispatch::IntegrationTest
  test "should get saihate" do
    get ta_saihate_url
    assert_response :success
  end

end
