require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "lucasbelt", email: "lucasbelt@hotmail.com",
                    password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "Name should be present" do
    @user.username = " "
    assert_not @user.valid?
  end

  test "Name should be less than 30 characters" do
    @user.username = "a" * 31
    assert_not @user.valid?
  end

  test "Email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "Email should not too long" do
    @user.email = "a" * 245 + "@example.com"
    assert_not @user.valid?
  end

  test "Email should accept correct format" do
    valid_emails = %w[user@example.com lucasbelt@hotmail.com l.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @user.email = valids
      assert @user.valid?, "#{valids.inspect} should be valid"
    end
  end

  test "Should reject invalid addresses" do
    invalid_emails = %w[user@example lucasbelt@hotmail,com l.first@yahoo. john@bar+uk.org]
    invalid_emails.each do |invalids|
      @user.email = invalids
      assert_not @user.valid?, "#{invalids.inspect} should be invalid"
    end
  end

  test "Email should be unique and case insensitive" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "Email should be lower case before hitting db" do
    mixed_email = "John@Example.com"
    @user.email = mixed_email
    @user.save
    assert_equal mixed_email.downcase, @user.reload.email
  end

  test "Password should be present" do
    @user.password = @user.password_confirmation = " "
    assert_not @user.valid?
  end

  test "Password at least 8 characters" do
    @user.password = @user.password_confirmation = "x" * 4
    assert_not @user.valid?
  end

end