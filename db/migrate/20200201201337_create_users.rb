class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: {unique: true}
      t.string :contact_number
      t.boolean :is_admin
      t.boolean :is_manager
      t.boolean :is_teacher
      t.boolean :is_student
      t.string :password_digest

      t.timestamps
    end
  end
end
