require 'rails_helper'

RSpec.describe "taxes/index", type: :view do
  before(:each) do
    assign(:taxes, [
      Tax.create!(
        name: "Name",
        description: "MyText",
        car: nil
      ),
      Tax.create!(
        name: "Name",
        description: "MyText",
        car: nil
      )
    ])
  end

  it "renders a list of taxes" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
