# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Repairs", type: :request do  
  it 'should generate correct routes' do
    assert_routing({ path: 'cars/1/repairs', method: :post },
                   { controller: 'repairs', action: 'create', car_id: '1' })
    assert_routing({ path: 'cars/1/repairs/1', method: :get },
                   { controller: 'repairs', action: 'show', id: '1', car_id: '1' })
    assert_routing({ path: '/cars/1/repairs/3', method: :delete},
                   { controller: 'repairs', action: 'destroy', id: '3', car_id: '1' })
    assert_routing({ path: '/cars/1/repairs/1', method: :put},
                   { controller: 'repairs', action: 'update', id: '1', car_id: '1' })
    assert_routing({ path: '/cars/1/repairs/5/edit', method: :get},
                  { controller: 'repairs', action: 'edit', id: '5', car_id: '1'  })
  end


  let(:car) { create(:car, user_id: user.id) }
  let(:user) { create(:user)}  

  describe 'POST ../repairs' do
    before(:each) do      
      sign_in user    
      post car_repairs_path(car_id: car.id), params: { repair: attributes_for(:repair) }
    end
    context 'with valid parameters' do
      it 'should respond with status 303 when created' do
        expect(response).to have_http_status(:see_other)
      end
      it 'should increase by one' do
        expect(Repair.count).to eq(1)
      end
    end
    context 'with invalid parameters' do
      context 'no license plate' do
        it 'should not save the repair' do          
          expect { post car_repairs_path(car_id: car.id), params: { repair: attributes_for(:repair, description: nil) }}.to change { Repair.count }.by(0)
          end
        end
      end
  end   

  describe 'DELETE ../repairs/:id' do    
    let(:repair) { create(:repair, car_id: car.id)}
    before(:each) do      
      sign_in user          
      delete car_repair_path(locale: :en, car_id: car.id, id: repair.id) 
    end        
    context 'with valid id' do                 
      it 'should delete repair' do
        expect(Repair.count).to eq(0)
        expect(response).to have_http_status(:see_other)
      end
    end
    context 'with invalid id of a car' do                 
      it 'should not delete repair' do
        expect(Repair.count).to eq(0)
        expect{delete car_repair_path(locale: :en, car_id: nil, id: repair.id)}.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end


  describe 'PUT ../repairs/:id' do    
    let(:test_repair) { create(:repair, car_id: car.id, description: "Old description") }
    before(:each) do      
      sign_in user          
      put car_repair_path(car_id: car.id, id: test_repair.id), params: { repair: attributes_for(:repair, description: "New description") }
      test_repair.reload
    end     
    context 'with valid parameters' do
      it 'should update the Repair' do
        expect(response).to have_http_status(:see_other)
        expect(test_repair.description).to eq("New description")
      end
    end
    context 'with invalid parameters' do
      it 'should not update the Repair' do
        put car_repair_path(car_id: car.id, id: test_repair.id), params: { repair: attributes_for(:repair, id: nil, description: 'Wrong description') }
        expect(test_repair.description).to eq("New description")
      end
    end
  end
end     