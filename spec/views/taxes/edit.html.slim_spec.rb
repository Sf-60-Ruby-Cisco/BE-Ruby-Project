require 'rails_helper'

RSpec.describe "taxes/edit", type: :view do
  before(:each) do
    @tax = assign(:tax, Tax.create!(
      name: "MyString",
      description: "MyText",
      car: nil
    ))
  end

  it "renders the edit tax form" do
    render

    assert_select "form[action=?][method=?]", tax_path(@tax), "post" do

      assert_select "input[name=?]", "tax[name]"

      assert_select "textarea[name=?]", "tax[description]"

      assert_select "input[name=?]", "tax[car_id]"
    end
  end
end
