require 'rails_helper'

RSpec.describe 'ChargingsController', type: :request do
  #************ Logged In User & his Car ************#
  let(:user) { create(:user) }
  before(:each) { sign_in user }
  let(:car) { create(:car, user_id: user.id) }


  #************* Different User & his Car *************#
  let(:user_2) { create(:user) }
  let(:car_2) { create(:car, user_id: user_2.id) }


  #************************  CREATE  ************************#
  describe 'POST cars/:car_id/chargings' do
    context 'with Valid parameters & Valid current_user' do
      it 'should increase Charging.count by 1' do
        expect { 
          post car_chargings_path(
            locale: 'en', 
            car_id: car.id, 
            format: :html
            ), params: { charging: attributes_for(:charging) } }.to change { Charging.count }.by(1)
        expect(response).to have_http_status(:see_other)
        expect(response).to redirect_to(car_url(id: car.id, params: {clear: "form", update: "chargings"}))
      end
    end

    context 'with Invalid parameters & Valid current_user' do
      it 'should NOT increase Charging.count' do
        expect{ 
          post car_chargings_path(
            locale: 'en', 
            car_id: car.id, 
            format: :turbo_stream
            ), params: { charging: attributes_for(:charging, amount: 0) }}.to_not change { Charging.count }
        expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with Valid parameters BUT Invalid current_user' do
      it 'should raise error(ActiveRecord::RecordNotFound)' do
        expect{car_2.reload}.to_not raise_error(ActiveRecord::RecordNotFound) 
        expect {
          post car_chargings_path(
            locale: 'en', 
            car_id: car_2.id, 
            format: :html
            ), 
            params: {charging: attributes_for(:charging)} }.to raise_error(ActiveRecord::RecordNotFound) 
      end
    end
  end

  #************************  UPDATE  *************************#
  describe 'PUT/PATCH cars/:car_id/chargings/:id' do
    let(:charging_to_update) { create(:charging, car_id: car.id) }

    context 'with Valid parameters & Valid current_user' do
      it 'should patch the Charging' do
        put car_charging_path(locale: 'en', car_id: car.id, id: charging_to_update.id, format: :turbo_stream), params: { charging: {:brand_station => "Lukoil"} }
        expect(charging_to_update.brand_station).to eq("OMV")
        charging_to_update.reload
        expect(charging_to_update.brand_station).to eq("Lukoil")
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
      end
    end

    context 'with Invalid parameters & Valid current_user' do
      it 'should NOT patch the Charging' do
        patch car_charging_path(locale: 'en', car_id: car.id, id: charging_to_update.id, format: :turbo_stream), params: { charging: {:amount => 0} }
        charging_to_update.reload

        current_amount = Money.new(charging_to_update.amount.dollars, "USD")
        expected_amount = Money.new(400, "USD")

        expect(current_amount).to eq(expected_amount)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
      end
    end

    context 'with Valid parameters BUT Invalid current_user' do
      let(:charging_to_update) { create(:charging, car_id: car_2.id) }

      it 'should raise error(ActiveRecord::RecordNotFound)' do
        expect { charging_to_update.reload }.to_not raise_error(ActiveRecord::RecordNotFound)
        expect { 
          put car_charging_path(
            locale: 'en', 
            car_id: car_2.id, 
            id: charging_to_update.id, 
            format: :turbo_stream
            ), params: { charging: {:brand_station => "Lukoil"} } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  #************************  DESTROY  ************************#
  describe 'DELETE cars/:car_id/chargings/:id' do
    let(:charging_to_destroy) { create(:charging, car_id: car.id) }

    context 'with Valid current_user' do
      it 'should destroy a Charging instance' do
        delete car_charging_path(locale: 'en', car_id: car.id, id: charging_to_destroy.id, format: :html)
        expect { charging_to_destroy.reload }.to raise_error(ActiveRecord::RecordNotFound) 
        expect(response).to have_http_status(:see_other)
        expect(response).to redirect_to(car_url(id: car.id, params: {update: "chargings"}))
      end
    end

    context 'with Invalid current_user' do
      let(:charging_to_destroy) { create(:charging, car_id: car_2.id) }
      it 'should Raise error(ActiveRecord::RecordNotFound)' do
        expect{ 
          delete car_charging_path(
            locale: 'en', 
            car_id: car_2.id, 
            id: charging_to_destroy.id, 
            format: :html
            )}.to raise_error(ActiveRecord::RecordNotFound) 
      end
    end
  end

end
