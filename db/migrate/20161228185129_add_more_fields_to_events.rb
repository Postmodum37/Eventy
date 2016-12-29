class AddMoreFieldsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :min_participants, :integer
    add_column :events, :max_participants, :integer
  end
end
