class AddPriceFieldsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :category, :string
    add_column :events, :place, :string
    add_column :events, :paid, :boolean, default: false
    add_column :events, :price, :decimal
  end
end
