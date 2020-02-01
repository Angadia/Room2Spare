class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title, index: {unique: true}
      t.string :description
      t.string :status
      t.integer :tuition
      t.integer :capacity
      t.string :image_url
      t.references :user, null: false, foreign_key: true 

      t.timestamps
    end
  end
end
