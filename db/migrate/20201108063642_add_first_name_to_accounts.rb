class AddFirstNameToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :first_name, :string
    add_column :accounts, :last_name, :string
    add_column :accounts, :pronouns, :string
    add_column :accounts, :class_year, :integer
    add_column :accounts, :majors, :string
    add_column :accounts, :minors, :string
    add_column :accounts, :interests, :string
  end
end
