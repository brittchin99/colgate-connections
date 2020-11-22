class Connection < ApplicationRecord
    belongs_to :profile, class_name: "Profile"
    belongs_to :friend, class_name: "Profile"
    
    validates :profile, uniqueness: {scope: :friend, message: "You can only add a friend once"}
    
    def create
    end

end