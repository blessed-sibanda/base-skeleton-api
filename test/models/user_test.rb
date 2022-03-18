require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "email cannot be blank" do
    @user.email = ""
    refute @user.valid?
  end

  test "name cannot be blank" do
    @user.name = ""
    refute @user.valid?
  end

  test "email should be unique" do
    @user.email = users(:two).email
    refute @user.valid?
  end

  test "email should be a valid e-mail address" do
    invalid_emails = ["xxx", "xxx.xx", "xxx@"]
    invalid_emails.each do |email|
      @user.email = email
      refute @user.valid?
    end

    @user.email = "test@example.com"
    assert @user.valid?
  end

  test "password must be at least 6 characters" do
    @user.password = "111"
    refute @user.valid?
  end
end
