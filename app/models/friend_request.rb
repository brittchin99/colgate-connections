class FriendRequest < ApplicationRecord
    belongs_to :profile, class_name: "Profile"
    belongs_to :friend, class_name: "Profile"
    
    validates :profile, uniqueness: {scope: :friend, message: "You can only send a friend request once for now"}
end
