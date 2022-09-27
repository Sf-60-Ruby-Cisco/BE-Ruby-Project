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
end
