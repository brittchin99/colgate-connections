class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :first_name
      t.string :last_name
      t.string :password
      t.string :pronouns
      t.integer :class_year
      t.string :majors
      t.string :minors
      t.string :interests

      t.timestamps
    end
  end
end
