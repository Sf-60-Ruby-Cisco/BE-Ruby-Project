class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.string :engine
      t.string :fuel_type
      t.date :year
      t.string :license_plate

      t.timestamps
    end
  end
end
