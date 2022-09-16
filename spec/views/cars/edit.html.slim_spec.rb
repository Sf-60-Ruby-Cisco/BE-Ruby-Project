require 'rails_helper'

RSpec.describe "cars/edit", type: :view do
  before(:each) do
    @car = assign(:car, Car.create!(
      brand: "MyString",
      model: "MyString",
      engine: "MyString",
      fuel_type: "MyString",
      license_plate: "MyString"
    ))
  end

  it "renders the edit car form" do
    render

    assert_select "form[action=?][method=?]", car_path(@car), "post" do

      assert_select "input[name=?]", "car[brand]"

      assert_select "input[name=?]", "car[model]"

      assert_select "input[name=?]", "car[engine]"

      assert_select "input[name=?]", "car[fuel_type]"

      assert_select "input[name=?]", "car[license_plate]"
    end
  end
end
