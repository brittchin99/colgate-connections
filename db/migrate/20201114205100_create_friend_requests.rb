class CreateFriendRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_requests do |t|
      t.belongs_to :account, foreign_key: true
      t.belongs_to :friend, foreign_key: false

      t.timestamps
    end
    add_foreign_key :friend_requests, :accounts, column: :friend_id
  end
end
