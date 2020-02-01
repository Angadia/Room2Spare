class CreateTimeSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :time_slots do |t|
      t.date :date
      t.time :start_time
      t.integer :duration
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
