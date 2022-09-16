class AddPriceToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_monetize :expenses, :price
  end
end
