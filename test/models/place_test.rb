require "test_helper"

class PlaceTest < ActiveSupport::TestCase
  setup do
    @place = places(:default)
  end

  test "valid place" do
    assert @place.valid?
  end

  test "invalid when latitude is less than -90" do
    @place.latitude = -91.0
    refute @place.valid?
    assert_not_nil @place.errors[:latitude]
  end

  test "invalid when latitude is greater than 90" do
    @place.latitude = 91.0
    refute @place.valid?
    assert_not_nil @place.errors[:latitude]
  end

  test "invalid when longitude is less than -180" do
    @place.longitude = -181.0
    refute @place.valid?
    assert_not_nil @place.errors[:longitude]
  end

  test "invalid when longitude is greater than 180" do
    @place.longitude = 181.0
    refute @place.valid?
    assert_not_nil @place.errors[:longitude]
  end

  test "invalid when name is less than 3 characters long" do
    @place.name = "t"
    refute @place.valid?
    assert_not_nil @place.errors[:name]
  end
end
