require "test_helper"

class Api::PlacesControllerTest < ActionDispatch::IntegrationTest
  test "should return all places when no params" do
    get api_places_url

    assert_response :success
    results = JSON.parse(response.body)

    assert_equal results.count, Place.count
  end

  test "should return places in radius when params are given" do
    target_place = places(:moscow)

    get api_places_url, params: { long: target_place.location.x, lat: target_place.location.y, radius: 10 }

    assert_response :success

    results = JSON.parse(response.body)

    assert_equal 1, results.count
    assert_equal target_place.id, results[0]["id"]
  end
end
