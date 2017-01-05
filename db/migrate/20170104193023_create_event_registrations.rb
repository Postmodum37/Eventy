class CreateEventRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :event_registrations do |t|
      t.integer :user_id
      t.integer :event_id
      t.boolean :confirmed, default: nil

      t.timestamps
    end
  end
end
