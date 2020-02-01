class CreateFeatureSets < ActiveRecord::Migration[6.0]
  def change
    create_table :feature_sets do |t|
      t.references :feature, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
