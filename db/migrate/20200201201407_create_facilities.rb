class CreateFacilities < ActiveRecord::Migration[6.0]
  def change
    create_table :facilities do |t|
      t.string :name
      t.string :description
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :contact_number
      t.boolean :parking
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
