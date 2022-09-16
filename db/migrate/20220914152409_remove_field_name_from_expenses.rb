class RemoveFieldNameFromExpenses < ActiveRecord::Migration[7.0]
  def change
    remove_column :expenses, :price
  end
end
