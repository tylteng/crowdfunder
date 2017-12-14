require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "email must be unique" do
    user = User.create(email: "bettymaker@gmail.com", password: "12345678", password_confirmation: "12345678")
    user2 = User.new(email: "bettymaker@gmail.com", password: "00000000", password_confirmation: "00000000")
    refute user2.valid?
  end

  test "user must include password_confirmation on create" do
    user = User.new(email: "bettymaker@gmail.com", password: "12345678")
    refute user.valid?
  end

  test "password must match confirmation" do
    user = User.new(email: "bettymaker@gmail.com", password: "12345678", password_confirmation: "87654321")
    refute user.valid?
  end

  test "password must be at least 8 characters long" do
    user = User.new(email: "bettymaker@gmail.com", password: "1234", password_confirmation: "1234")
    refute user.valid?
  end

  test "full_name" do
    user = create(:user)
    assert_equal("Ty Dollar", user.full_name)
  end

  test "user_has_a_password" do
    user = build(:user, password: nil, password_confirmation: nil)
    # user = (user.passwor_confirmation = nil)
    assert user.invalid?
  end

  test "pledge_total" do
    user = build(:user)
    pledge1 = create(:pledge, user: user, dollar_amount: 100)
    dollar = user.pledge_total
    assert_equal(100, dollar)
  end

  test 'projects_supported' do
    
  end



end
