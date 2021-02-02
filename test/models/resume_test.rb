require "test_helper"

class ResumeTest < ActiveSupport::TestCase

=begin
  def setup
    @user = User.create!(username: "lucasbelt", email: "lucas@example.com")
    @resume = @user.resume.build(name: "Luis Carlos Correa Martinez", description: "Great RoR Resume")
  end

  test "Resume without user should be invalid" do
    @resume.user_id = nil
    assert_not @resume.valid?
  end

  test "Resume should be valid" do
    assert @resume.valid?
  end

  test "name should be present" do
    @resume.name = " "
    assert_not @resume.valid?
  end

  test "description should be present" do
    @resume.description = " "
    assert_not @resume.valid?
  end

  test "description shouldn't be less than 5 characters" do
    @resume.description = "a" * 3
    assert_not @resume.valid?
  end

  test "description shouldn't be more than 500 characters" do
    @resume.description = "a" * 501
    assert_not @resume.valid?
  end
=end

end