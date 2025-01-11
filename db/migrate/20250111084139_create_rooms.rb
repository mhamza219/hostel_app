class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :room_number
      t.integer :capacity
      t.decimal :price
      t.integer :hostel_id

      t.timestamps
    end
  end
end
