require 'rails_helper'

RSpec.describe "Cars", type: :request do  
  
  it 'should generate correct routes' do
    assert_routing({ path: 'cars', method: :post },
                   { controller: 'cars', action: 'create', locale: 'en' })
    assert_routing({ path: 'en/cars/1', method: :get },
                   { controller: 'cars', action: 'show', id: '1', locale: 'en'  })
    assert_routing({ path: 'en/cars/3', method: :delete},
                   { controller: 'cars', action: 'destroy', id: '3', locale: 'en'  })
    assert_routing({ path: 'en/cars/1', method: :put},
                   { controller: 'cars', action: 'update', id: '1', locale: 'en' })
    assert_routing({ path: 'en/cars/1/edit', method: :get},
                  { controller: 'cars', action: 'edit', id: '1', locale: 'en' })
  end

  let!(:user) { FactoryBot.create(:user)}
  before(:each) { sign_in user }

  describe 'GET /cars' do
    let!(:car) { create(:car) }
    before(:each) { get cars_path }
    it 'should render the correct template' do
      expect(response).to have_http_status(200)
      expect(response).to render_template :index
    end 
  end

  describe 'POST /cars' do
    context 'with valid parameters' do
      it 'should increase by one' do
        expect { post cars_path, params: { car: attributes_for(:car) } }
          .to change { Car.count }.by(1)
      end
    end
    context 'with invalid parameters' do
      context 'no license plate' do
        it 'should not save the car' do
          expect { post cars_path, params: { car: attributes_for(:car, license_plate: nil) } }
          .to change { Car.count }.by(0)
        end
      end
    end  
  end

  describe 'DELETE /cars/:id' do
    context 'with valid id' do
      let!(:car) { create(:car) }      
        it 'should delete car' do
          expect { delete car_path(id: car.id) }.to change { Car.count }.by(-1)
        end
    end
  end
end
