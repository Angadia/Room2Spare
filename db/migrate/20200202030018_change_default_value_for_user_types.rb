class ChangeDefaultValueForUserTypes < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:users, :is_admin,   from: nil, to: false)
    change_column_default(:users, :is_manager, from: nil, to: false)
    change_column_default(:users, :is_teacher, from: nil, to: false)
    change_column_default(:users, :is_student, from: nil, to: false)
  end
end
