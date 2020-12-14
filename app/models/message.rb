class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :profile
  require 'date'
  
  validates_presence_of :body, :conversation_id, :profile_id
  
  def message_time
    created_at.in_time_zone("Eastern Time (US & Canada)").strftime("%m/%d/%y at %l:%M %p")
  end
  
  
  def get_display_date
    time = self.message_time.match(/[0-9]{1,2}:[0-9]{2} (AM|PM)/)
    if self.created_at >= Date.today
      return time
    end
    if self.created_at >= Date.yesterday
      return "Yesterday"  
    end
    if Range.new(self.created_at-7, self.created_at - 1).include?(Date.today)
      day = self.created_at.in_time_zone("Eastern Time (US & Canada)").strftime("%A")
      return day
    else
      return self.created_at.in_time_zone("Eastern Time (US & Canada)").strftime("%m/%d/%y")
    end
  end
end
