class AddEmailToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :email, :string
  end
end
