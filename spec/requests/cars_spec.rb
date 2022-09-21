require 'rails_helper'

RSpec.describe "Cars", type: :request do  
  it 'should generate correct routes' do
    assert_routing({ path: 'cars', method: :post },
                   { controller: 'cars', action: 'create' })
    assert_routing({ path: 'cars/1', method: :get },
                   { controller: 'cars', action: 'show', id: '1' })
    assert_routing({ path: 'cars/3', method: :delete},
                   { controller: 'cars', action: 'destroy', id: '3' })
    assert_routing({ path: 'cars/1', method: :put},
                   { controller: 'cars', action: 'update', id: '1' })
  end
end