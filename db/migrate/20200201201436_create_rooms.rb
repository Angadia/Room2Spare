class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :capacity
      t.string :area
      t.string :image_url
      t.boolean :whiteboard
      t.boolean :internet
      t.references :facility, null: false, foreign_key: true

      t.timestamps
    end
  end
end
