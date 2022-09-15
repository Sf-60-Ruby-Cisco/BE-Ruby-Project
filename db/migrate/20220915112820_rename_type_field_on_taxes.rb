class RenameTypeFieldOnTaxes < ActiveRecord::Migration[7.0]
  def change
    remove_column :taxes, :type
    add_column :taxes, :tax_type, :string
  end
end
