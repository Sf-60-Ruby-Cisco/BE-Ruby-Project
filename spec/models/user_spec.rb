# frozen_string_literal: true

require 'rails_helper'


RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_one_attached(:content) }
    it { should have_many(:cars) }
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }  
    it { should validate_length_of(:username).is_at_most(40) }
    it { should validate_length_of(:username).is_at_least(3) }
    it { should validate_length_of(:password).is_at_most(20) }
    it { should validate_length_of(:password).is_at_least(6) }    
    it { should validate_uniqueness_of(:username) }    
  end    


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
