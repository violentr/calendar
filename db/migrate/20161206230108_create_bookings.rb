class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :room_id
      t.date :start, null: false
      t.date :end, null: false
      t.timestamps null: false
    end

    add_index :bookings, :room_id
  end
end
