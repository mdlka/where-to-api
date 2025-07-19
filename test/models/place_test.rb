require "test_helper"

class PlaceTest < ActiveSupport::TestCase
  test "place latitude should be greater than -90" do
    place = Place.new(name: "test", latitude: -91, longitude: 0)
    assert_not place.save
  end

  test "place latitude should be less than 90" do
    place = Place.new(name: "test", latitude: 91, longitude: 0)
    assert_not place.save
  end

  test "place longitude should be greater than -180" do
    place = Place.new(name: "test", latitude: 0, longitude: -181)
    assert_not place.save
  end

  test "place longitude should be less than 180" do
    place = Place.new(name: "test", latitude: 0, longitude: 181)
    assert_not place.save
  end

  test "place name should be at least 3 chars long" do
    place = Place.new(name: "t", latitude: 0, longitude: 0)
    assert_not place.save
  end
end
