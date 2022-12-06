class FixingExpenses2 < ActiveRecord::Migration[7.0]
  def change
    remove_reference :cars, :expense,  index: true, foreign_key: true
    add_reference :expenses, :car, index: true, foreign_key: true
  end
end
