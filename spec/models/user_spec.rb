require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:each) do
      @user = User.new
      @user.name = "Theodore Thucksbury"
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.email = "user@email.com"
    end
    it 'should be created with a password and password_confirmation fields' do
      @user.valid?
      
      expect(@user).to be_valid
    end
    it 'should not be created if password and password_confirmation dont match' do
      @user.password_confirmation = "passwor"
      @user.valid?

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end 
    it 'should not validate if password_confirmation is not present' do
      @user.password_confirmation = nil
      @user.valid?

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end 
    it 'should not validate if email is not unique' do
      @user.save

      @user2 = User.new
      @user2.name = "Timmy Tuney"
      @user2.password = "password"
      @user2.password_confirmation = "password"
      @user2.email = "user@email.com"
      @user2.valid?

      expect(@user).to be_valid
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
    it 'should have a password of at least 5 characters' do
      @user.password = "pass"
      @user.password_confirmation = "pass"
      @user.valid?

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end 
  end
  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new
      @user.name = "Theodore Thucksbury"
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.email = "user@email.com"
    end
    it 'should return instance of user' do
      @user.save
      login = User.authenticate_with_credentials(@user.email, @user.password)
      expect(login).to eql(@user)
    end
    it 'should return nil if email is not registered' do
      @user.save
      login = User.authenticate_with_credentials("user.email", @user.password)
      expect(login).to eql(nil)
    end
    it 'should return nil if password is not registered' do
      @user.save
      login = User.authenticate_with_credentials(@user.email, "passwor")
      expect(login).to eql(nil)
    end
    it 'should allow login if email has whitespace around it' do
      @user.save
      login = User.authenticate_with_credentials(" user@email.com ", @user.password)
      expect(login).to eql(@user)
    end
  end
end
