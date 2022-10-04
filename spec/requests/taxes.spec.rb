# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Taxes", type: :request do  
  it 'should generate correct routes' do
    assert_routing({ path: 'cars/1/taxes', method: :post },
                   { controller: 'taxes', action: 'create', car_id: '1' })
    assert_routing({ path: 'cars/1/taxes/1', method: :get },
                   { controller: 'taxes', action: 'show', id: '1', car_id: '1' })
    assert_routing({ path: '/cars/1/taxes/3', method: :delete},
                   { controller: 'taxes', action: 'destroy', id: '3', car_id: '1' })
    assert_routing({ path: '/cars/1/taxes/1', method: :put},
                   { controller: 'taxes', action: 'update', id: '1', car_id: '1' })
    assert_routing({ path: '/cars/1/taxes/5/edit', method: :get},
                  { controller: 'taxes', action: 'edit', id: '5', car_id: '1'  })
  end

  let(:car) { create(:car, user_id: user.id) }
  let(:user) { create(:user)}  

  describe 'This test should fail' do
    context 'fail' do
      expect("123").to eq("12")
    end
  end
  
  describe 'POST ../taxes' do
    before(:each) do      
      sign_in user    
      post car_taxes_path(car_id: car.id), params: { tax: attributes_for(:tax) }
    end
    context 'with valid parameters' do
      it 'should respond with status 303 when created' do
        expect(response).to have_http_status(:see_other)
      end
      it 'should increase by one' do
        expect(Tax.count).to eq(1)
      end
    end
    context 'with invalid parameters' do
      context 'no tax type' do
        it 'should not save the tax' do          
          expect { post car_taxes_path(car_id: car.id), params: { tax: attributes_for(:tax, tax_type: nil) }}.to change { Tax.count }.by(0)
          end
        end
      end
  end 
    

  let(:tax) { create(:tax, car_id: car.id)}

  describe 'DELETE ../taxes/:id' do    
    before(:each) do      
      sign_in user          
      delete car_tax_path(locale: :en, car_id: car.id, id: tax.id) 
    end        
    context 'with valid id' do                 
      it 'should delete tax' do
        expect(Tax.count).to eq(0)
        expect(response).to have_http_status(:see_other)
      end
    end
    context 'with invalid id of a car' do                 
      it 'should not delete tax' do
        expect(Tax.count).to eq(0)
        expect{delete car_tax_path(locale: :en, car_id: nil, id: tax.id)}.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end


  describe 'PUT ../taxes/:id' do    
    let(:test_tax) { create(:tax, car_id: car.id, tax_type: "Annual") }
    before(:each) do      
      sign_in user          
      put car_tax_path(car_id: car.id, id: test_tax.id), params: { tax: attributes_for(:tax, tax_type: 'Monthly') }
      test_tax.reload
    end     
    context 'with valid parameters' do
      it 'should update the Tax' do
        expect(response).to have_http_status(:see_other)
        expect(test_tax.tax_type).to eq("Monthly")
      end
    end
    context 'with invalid parameters' do
      it 'should no update the Tax' do
        put car_tax_path(car_id: car.id, id: test_tax.id), params: { tax: attributes_for(:tax, id: nil, tax_type: 'New type') }
        expect(test_tax.tax_type).to eq("Monthly")
      end
    end
  end
end     
