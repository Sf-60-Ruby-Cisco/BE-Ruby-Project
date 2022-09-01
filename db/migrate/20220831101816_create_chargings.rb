class CreateChargings < ActiveRecord::Migration[7.0]
  def change
    create_table :chargings do |t|
      t.string :brand_station
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.date :date
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
