class Conversation < ApplicationRecord
    belongs_to :sender, :foreign_key => :sender_id, class_name: 'Profile'
    belongs_to :receiver, :foreign_key => :receiver_id, class_name: 'Profile'

    has_many :messages, dependent: :destroy
    validates_uniqueness_of :sender_id, :scope => :receiver_id
    scope :between, -> (sender_id,receiver_id) do
        where("(conversations.sender_id = ?
        AND conversations.receiver_id =?)
        OR (conversations.sender_id = ?
        AND conversations.receiver_id =?)", sender_id,receiver_id, receiver_id, sender_id)
    end
    
    def has_messages?
        self.messages.length > 0
    end
    
    def has_unread_messages?
        if self.messages.last == nil
            return FALSE
        else
            return !self.messages.last.read
        end
    end
    
    def last_message
        len = self.messages.length
        self.messages[len - 1]
    end
end
