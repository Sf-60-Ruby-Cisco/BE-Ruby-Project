require 'rails_helper'

RSpec.describe "taxes/new", type: :view do
  before(:each) do
    assign(:tax, Tax.new(
      name: "MyString",
      description: "MyText",
      car: nil
    ))
  end

  it "renders new tax form" do
    render

    assert_select "form[action=?][method=?]", taxes_path, "post" do

      assert_select "input[name=?]", "tax[name]"

      assert_select "textarea[name=?]", "tax[description]"

      assert_select "input[name=?]", "tax[car_id]"
    end
  end
end
