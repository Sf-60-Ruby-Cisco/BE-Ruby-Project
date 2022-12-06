require 'rails_helper'

RSpec.describe "expenses/index", type: :view do
  before(:each) do
    assign(:expenses, [
      Expense.create!(
        description: "Description",
        amount: 2.5
      ),
      Expense.create!(
        description: "Description",
        amount: 2.5
      )
    ])
  end

  it "renders a list of expenses" do
    render
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: 2.5.to_s, count: 2
  end
end
