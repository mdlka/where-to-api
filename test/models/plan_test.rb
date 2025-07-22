require "test_helper"

class PlanTest < ActiveSupport::TestCase
  setup do
    @plan = plans(:default)
  end

  test "valid plan" do
    assert @plan.valid?
  end

  test "invalid when title is empty" do
    @plan.title = ""
    refute @plan.valid?
    assert_not_nil @plan.errors[:title]
  end
end
