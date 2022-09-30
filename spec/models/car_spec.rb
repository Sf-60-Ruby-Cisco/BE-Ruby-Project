require 'rails_helper'

                                                         
RSpec.describe Car, type: :model do

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_one_attached(:content) }
    it { should have_many(:repairs) }
    it { should have_many(:chargings) }
    it { should have_many(:taxes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:license_plate) }
    it { should validate_presence_of(:year) }    
    it { should validate_length_of(:brand).is_at_most(20) }
    it { should validate_length_of(:model).is_at_most(20) }
    it { should validate_length_of(:engine).is_at_most(20) }    
    it { should validate_length_of(:license_plate).is_at_least(6) }
    it { should validate_length_of(:license_plate).is_at_most(8) }    
  end    

  context 'with valid attributes' do
    it 'should be valid' do
      expect(create(:car)).to be_valid
    end
  end

  context 'with invalid attributes' do
    context 'with invalid license_plate' do
      it 'should be invalid' do
        expect(build(:car, license_plate: nil)).to_not be_valid
      end
    end

    context 'with no associations to user' do
      it 'should be invalid' do
        expect(build(:car, user_id: nil)).to_not be_valid
      end
    end      
  end
end