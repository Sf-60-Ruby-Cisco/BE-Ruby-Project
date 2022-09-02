class TaxesChangeColumnType < ActiveRecord::Migration[7.0]
  def change
    change_column(:taxes, :car_id, :bigint)
  end
end
