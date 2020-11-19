class AddFirstNameToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :first_name, :string
    add_column :accounts, :last_name, :string
    add_column :accounts, :pronouns, :string
    add_column :accounts, :class_year, :integer
    add_column :accounts, :majors, :text
    add_column :accounts, :minors, :text
    add_column :accounts, :interests, :text
    add_column :accounts, :status, :text
  end
end
