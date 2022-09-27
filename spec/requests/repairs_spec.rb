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


  let(:user) { create(:user)}  
  before(:each) { sign_in user }
  let(:car) { create(:car, user_id: user.id) }
  
  describe 'POST /repairs' do
    context 'with valid parameters' do
      it 'should respond with status 303 when created' do
        post car_repairs_path(car_id: car.id), params: { repair: attributes_for(:repair) }
        expect(response).to have_http_status(:see_other)
      end
    end
  end

  describe 'POST /repairs' do
    context 'with valid parameters' do
      it 'should increase by one' do
        expect { post car_repairs_path(car_id: car.id), params: { repair: attributes_for(:repair) }}.to change { Repair.count }.by(1)
      end
    end
  end  

  context 'with invalid parameters' do
    context 'no description' do
      it 'should not save the repair' do
          expect { post car_repairs_path(car_id: car.id), params: { repair: attributes_for(:repair, description: nil) }}.to change { Repair.count }.by(0)
        end
      end
    end
    
    describe 'DELETE /repairs/:id' do      
      context 'with valid id' do         
        let!(:repair) { create(:repair, car_id: car.id)}
        it 'should delete repair' do
          expect { delete car_repair_path(locale: :en, car_id: car.id, id: repair.id) }.to change { Repair.count }.by(-1)
        end
      end
    end
end     
