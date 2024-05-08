class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.time :date
      t.time :start_time
      t.time :end_time
      t.integer :quantity
      t.float :price
      t.integer :num_seats
      t.integer :num_booked

      t.timestamps
    end
  end
end
