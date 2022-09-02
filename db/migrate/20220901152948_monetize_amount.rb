class MonetizeAmount < ActiveRecord::Migration[7.0]
  def change
    add_monetize :chargings, :amount
    remove_column :chargings, :amount
  end
end
