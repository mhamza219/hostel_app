class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.integer :room_id
      t.integer :resident_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
