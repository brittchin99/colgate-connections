class Connection < ApplicationRecord
    belongs_to :account
    belongs_to :friend, class_name: "Account"
    
    def self.create_reciprocal_for_ids(account_id, friend_id)
      account_connection = Connection.create(account_id: account_id, friend_id: friend_id)
      friend_connection = Connection.create(account_id: friend_id, friend_id: account_id)
      [account_connection, friend_connection]
    end
    def self.destroy_reciprocal_for_ids(account_id, friend_id)
      connection1 = Connection.find_by(account_id: account_id, friend_id: friend_id)
      connection2 = Connection.find_by(account_id: friend_id, friend_id: account_id)
      connection1.destroy
      connection2.destroy
    end
private
end