require 'rails_helper'

RSpec.describe "cars/index", type: :view do
  before(:each) do
    assign(:cars, [
      Car.create!(
        brand: "Brand",
        model: "Model",
        engine: "Engine",
        fuel_type: "Fuel Type",
        license_plate: "License Plate"
      ),
      Car.create!(
        brand: "Brand",
        model: "Model",
        engine: "Engine",
        fuel_type: "Fuel Type",
        license_plate: "License Plate"
      )
    ])
  end

  it "renders a list of cars" do
    render
    assert_select "tr>td", text: "Brand".to_s, count: 2
    assert_select "tr>td", text: "Model".to_s, count: 2
    assert_select "tr>td", text: "Engine".to_s, count: 2
    assert_select "tr>td", text: "Fuel Type".to_s, count: 2
    assert_select "tr>td", text: "License Plate".to_s, count: 2
  end
end
