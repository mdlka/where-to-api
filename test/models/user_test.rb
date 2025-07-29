require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = User.create(email: "test@example.com", password: "test123")
    assert user.valid?
  end

  test "invalid when email without @ symbol" do
    user = User.create(email: "testexample.com", password: "test123")
    refute user.valid?
    assert_not_nil user.errors[:email]
  end

  test "invalid when email without domain" do
    user = User.create(email: "test@", password: "test123")
    refute user.valid?
    assert_not_nil user.errors[:email]
  end

  test "invalid when email with only username" do
    user = User.create(email: "test", password: "test123")
    refute user.valid?
    assert_not_nil user.errors[:email]
  end

  test "invalid when password is less than 6 characters long" do
    user = User.create(email: "test1@example.com", password: "test")
    refute user.valid?
    assert_not_nil user.errors[:password]
  end
end
