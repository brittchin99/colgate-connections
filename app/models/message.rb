class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :account
  
  validates_presence_of :body, :conversation_id, :account_id
  
  def message_time
    created_at.in_time_zone("Eastern Time (US & Canada)").strftime("%m/%d/%y at %l:%M %p")
  end
end
