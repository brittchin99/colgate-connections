class CreatePreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :preferences do |t|
      t.text :pronouns
      t.text :class_years
      t.belongs_to :setting, foreign_key: true 
      t.timestamps
    end
  end
end
