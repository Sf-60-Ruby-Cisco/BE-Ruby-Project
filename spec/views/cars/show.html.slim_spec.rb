require 'rails_helper'

RSpec.describe "cars/show", type: :view do
  before(:each) do
    @car = assign(:car, Car.create!(
      brand: "Brand",
      model: "Model",
      engine: "Engine",
      fuel_type: "Fuel Type",
      license_plate: "License Plate"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Brand/)
    expect(rendered).to match(/Model/)
    expect(rendered).to match(/Engine/)
    expect(rendered).to match(/Fuel Type/)
    expect(rendered).to match(/License Plate/)
  end
end
