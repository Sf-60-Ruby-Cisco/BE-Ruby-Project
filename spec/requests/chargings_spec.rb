require 'rails_helper'


RSpec.describe '/cars/car_id/chargings', type: :request do
  let(:user) { create(:user) }
  before(:each) { sign_in user }
  let(:car) { create(:car, user_id: user.id) }

  describe 'POST /chargings' do
    context 'with valid parameters' do
      it 'should increase by one' do
        expect{ post car_chargings_path(locale: 'en', car_id: car.id, format: :html), params: { charging: attributes_for(:charging) }}.to change { Charging.count }.by(1)
        expect(response).to have_http_status(:see_other)
      end
    end
  end

end
