class CreateAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :availabilities do |t|
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.integer :one_hour_rental_price
      t.references :room, null: false, foreign_key: true


      t.timestamps
    end
  end
end
