# frozen_string_literal: true

require 'rails_helper'
                                                         
RSpec.describe Tax, type: :model do
  describe 'associations' do
    it { should belong_to(:car) }
  end

  describe 'validations' do   
    it { should validate_presence_of(:tax_type) }
    it { should validate_numericality_of(:amount_cents) } 
    it { should validate_length_of(:description).is_at_most(350) } 
    it { should validate_length_of(:tax_type).is_at_least(3).is_at_most(100) } 
  end    

  context 'with valid attributes' do
    it 'should be valid' do
      expect(create(:tax)).to be_valid      
    end
  end

  context 'with no associations to car' do   
      it 'should be invalid' do
        expect(build(:tax, car_id: nil)).to_not be_valid
      end
    end
    
end
