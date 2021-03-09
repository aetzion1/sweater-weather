require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of :email}
    it {should validate_presence_of :password}
    it {should validate_presence_of :password_confirmation}
  end

  describe "registration happy paths" do
    it "ensures email is case insensitive" do
      email = 'EXAMPLE@eXaMpLe.CoM'
 
      expect(user.email).to eq('example@example.com')
    end
  end

  describe "registration sad paths" do
    it "email is blank" do
      user = User.new(email: '', password: 'password', password_confirmation: 'password')
      expect(user.save).to eq(false)
    end
    
    it "password doesn't match password confirmation" do
      user = User.new(email: "example@example.com", password: 'password', password_confirmation: 'paSsword')
      expect(user.save).to eq(false)
    end
  end
end
