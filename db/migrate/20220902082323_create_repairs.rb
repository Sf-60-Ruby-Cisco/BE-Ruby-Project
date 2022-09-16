class CreateRepairs < ActiveRecord::Migration[7.0]
  def change
    create_table :repairs do |t|
      t.text :description
      t.monetize :amount, null: false
      t.date :date
      t.references :car, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
