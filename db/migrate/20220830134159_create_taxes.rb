class CreateTaxes < ActiveRecord::Migration[7.0]
  def change
    create_table :taxes do |t|
      t.string :name
      t.text :description
      t.date :from_date
      t.date :until_date
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
