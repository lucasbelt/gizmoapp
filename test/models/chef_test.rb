require "test_helper"

class ChetTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "lucasbelt", email: "lucasbelt@hotmail.com",
                    password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @chef.valid?
  end

  test "Name should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "Name should be less than 30 characters" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end

  test "Email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "Email should not too long" do
    @chef.email = "a" * 245 + "@example.com"
    assert_not @chef.valid?
  end

  test "Email should accept correct format" do
    valid_emails = %w[user@example.com lucasbelt@hotmail.com l.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end

  test "Should reject invalid addresses" do
    invalid_emails = %w[user@example lucasbelt@hotmail,com l.first@yahoo. john@bar+uk.org]
    invalid_emails.each do |invalids|
      @chef.email = invalids
      assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
    end
  end

  test "Email should be unique and case insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test "Email should be lower case before hitting db" do
    mixed_email = "John@Example.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end

  test "Password should be present" do
    @chef.password = @chef.password_confirmation = " "
    assert_not @chef.valid?
  end

  test "Password at least 8 characters" do
    @chef.password = @chef.password_confirmation = "x" * 4
    assert_not @chef.valid?
  end

end