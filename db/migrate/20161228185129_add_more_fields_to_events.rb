class AddMoreFieldsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :min_participants, :integer
    add_column :events, :max_participants, :integer
    add_column :events, :category, :string
    add_column :events, :place, :string
    add_column :events, :paid, :boolean
    add_column :events, :price, :decimal
  end
end
