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
end
