require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with valid attribues' do
    it 'is valid with valid atributes' do
      expect(create(:user)).to be_valid 
    end
  end

  context 'with invalid attribues' do  
    it 'is not valid without password' do
      expect(build(:user, password: nil)).to_not be_valid  
    end

    it 'is not valid with difference in confirm password' do
      expect(build(:user, password_confirmation: '123')).to_not be_valid
    end

    it 'is not valid with emopty space in username' do
      expect(build(:user, username: 'Test Test')).to_not be_valid
    end

    it 'is not valid without email' do
      expect(build(:user, email: nil)).to_not be_valid   
    end

    it 'is not valid with invalid email' do
      expect(build(:user, email: "Invalidmail@")).to_not be_valid      
    end  
    
    it 'rejects names that are too long' do
      expect(build(:user, username: "a" * 41)).to_not be_valid    
    end     

  end
end
