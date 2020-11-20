class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :string
      t.string :pronouns
      t.integer :class_year
      t.text :majors
      t.text :minors
      t.text :interests
      t.text :status
      t.belongs_to :account, foreign_key: true 

      t.timestamps
    end
  end
end
