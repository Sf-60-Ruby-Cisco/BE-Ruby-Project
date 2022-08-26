require 'rails_helper'

RSpec.describe "cars/new", type: :view do
  before(:each) do
    assign(:car, Car.new(
      brand: "MyString",
      model: "MyString",
      engine: "MyString",
      fuel_type: "MyString",
      license_plate: "MyString"
    ))
  end

  it "renders new car form" do
    render

    assert_select "form[action=?][method=?]", cars_path, "post" do

      assert_select "input[name=?]", "car[brand]"

      assert_select "input[name=?]", "car[model]"

      assert_select "input[name=?]", "car[engine]"

      assert_select "input[name=?]", "car[fuel_type]"

      assert_select "input[name=?]", "car[license_plate]"
    end
  end
end
