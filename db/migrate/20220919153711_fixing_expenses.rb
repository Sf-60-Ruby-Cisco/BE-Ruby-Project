class FixingExpenses < ActiveRecord::Migration[7.0]
  def change
    remove_reference :cars, :expenses,  index: true, foreign_key: true
    add_reference :expenses, :cars, index: true, foreign_key: true
  end
end
