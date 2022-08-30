require 'rails_helper'

RSpec.describe "taxes/show", type: :view do
  before(:each) do
    @tax = assign(:tax, Tax.create!(
      name: "Name",
      description: "MyText",
      car: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
