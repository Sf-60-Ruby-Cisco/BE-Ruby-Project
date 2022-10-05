class ChangingColumnNameInExpenses < ActiveRecord::Migration[7.0]
  def change
    remove_monetize :expenses, :price
    add_monetize :expenses, :amount
  end
end
