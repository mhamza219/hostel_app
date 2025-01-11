class CreateHostels < ActiveRecord::Migration[6.1]
  def change
    create_table :hostels do |t|
      t.string :hostel_name
      t.string :address
      t.integer :pincode
      t.integer :contact_number
      t.string :ratings
      t.text :description

      t.timestamps
    end
  end
end
