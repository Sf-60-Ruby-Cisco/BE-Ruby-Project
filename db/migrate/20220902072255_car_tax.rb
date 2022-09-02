class CarTax < ActiveRecord::Migration[7.0]
  def change
    create_table :car_taxes do |t|
      t.references :car, null: false, foreign_key: true
      t.references :tax, null: false, foreign_key: true

      t.timestamps
    end
  end
end
