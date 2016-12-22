class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.decimal :lat
      t.decimal :lng
      t.string :title
      t.string :address
      t.string :country
      t.string :city
      t.string :street
      t.string :street_number
      t.string :postal_code
      t.datetime :start_date
      t.datetime :end_date
      t.string :contact_email
      t.string :contact_phone
      t.integer :capacity
      t.text :description
      t.references :user
      t.timestamps
    end
  end
end
