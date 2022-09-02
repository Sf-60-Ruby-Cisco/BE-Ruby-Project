class AddAmountToTaxes < ActiveRecord::Migration[7.0]
  def change
    add_column :taxes, :amount_cents, :integer
    add_column :taxes, :amount_currency, :string
  end
end
