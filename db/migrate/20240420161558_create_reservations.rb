class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :checkin
      t.date :checkout
      t.integer :people
      t.integer :stay_days
      t.integer :price
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
