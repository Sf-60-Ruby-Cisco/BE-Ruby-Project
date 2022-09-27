# frozen_string_literal: true

require 'rails_helper'

                                                         
RSpec.describe Repair, type: :model do

  describe 'associations' do
    it { should belong_to(:car) }
    it { should have_one_attached(:content) }
  end

 describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:description) }    
    it { should validate_length_of(:description).is_at_most(255) }
    it { should validate_length_of(:description).is_at_least(3) } 
  end  

  context 'with valid attributes' do
    it 'should be valid' do
      expect(create(:repair)).to be_valid
    end
  end

  context 'with invalid attributes' do
    context 'with invalid license_plate' do
      it 'should be invalid' do
        expect(build(:repair, description: nil)).to_not be_valid
      end
    end
  end

  context 'with no associations to car' do
    it 'should be invalid' do
      expect(build(:repair, car_id: nil)).to_not be_valid
    end
  end 
  
end
