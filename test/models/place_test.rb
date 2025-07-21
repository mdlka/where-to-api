require "test_helper"

class PlaceTest < ActiveSupport::TestCase
  setup do
    @place = places(:default)
  end

  test "valid place" do
    assert @place.valid?
  end

  test "invalid when name is less than 3 characters long" do
    @place.name = "t"
    refute @place.valid?
    assert_not_nil @place.errors[:name]
  end

  test "in_radius should return places within radius" do
    moscow = places(:moscow)
    spb = places(:spb)

    results = Place.in_radius(moscow.location.x, moscow.location.y, 100_000)

    assert_includes results, moscow
    refute_includes results, spb
  end
end
