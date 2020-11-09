class Connection < ApplicationRecord
    belongs_to :account, class_name: "Account"
    belongs_to :friend, class_name: "Account"
    
    validates :account, uniqueness: {scope: :friend, message: "You can only add a friend once"}
    
    def create
    end

end