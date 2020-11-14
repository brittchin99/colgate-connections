class FriendRequest < ApplicationRecord
    belongs_to :account, class_name: "Account"
    belongs_to :friend, class_name: "Account"
    
    validates :account, uniqueness: {scope: :friend, message: "You can only send a friend request once for now"}
end
