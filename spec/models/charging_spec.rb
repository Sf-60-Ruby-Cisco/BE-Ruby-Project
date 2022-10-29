require 'rails_helper'

RSpec.describe Charging, type: :model do
  # Associations
  it { is_expected.to belong_to(:car) }

  # Validations
  it { should validate_numericality_of(:amount_cents) }

  # Columns
  it { is_expected.to have_db_column(:brand_station).of_type(:string) }
  it { is_expected.to have_db_column(:date).of_type(:date) }
  it { is_expected.to have_db_column(:car_id).of_type(:integer) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:amount_cents).of_type(:integer) }
  it { is_expected.to have_db_column(:amount_currency).of_type(:string) }
  it { should have_db_index(:car_id) }

  # Creation with Valid attributes
  context 'with valid attribues' do
    it 'is valid with valid atributes' do
      expect(create(:charging)).to be_valid 
    end
  end

  # Creation with Invalid attributes
  context 'with invalid attribues' do
    it 'is not valid with null car' do
      expect(build(:charging, car: nil)).to_not be_valid  
    end
  end  
end