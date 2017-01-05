class RemoveCapacityFromEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :capacity
  end
end
