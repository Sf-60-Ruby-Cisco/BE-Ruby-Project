class AddExpenseToCar < ActiveRecord::Migration[7.0]
  def change
    add_reference :expenses, :cars, index: true, foreign_key: true
  end
end
