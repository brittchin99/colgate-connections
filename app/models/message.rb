class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :profile
  require 'date'
  
  validates_presence_of :body, :conversation_id, :profile_id
  
  def message_time
    created_at.in_time_zone(Time.zone).strftime("%m/%d/%y at %l:%M %p")
  end
  
  
  def get_display_date
    time = self.message_time.match(/[0-9]{1,2}:[0-9]{2} (AM|PM)/)
    message_date = self.created_at.in_time_zone(Time.zone).strftime("%m/%d/%y")
    if message_date >= Time.zone.today.strftime("%m/%d/%y")
      return time
    end
    if message_date ==  Time.zone.yesterday.strftime("%m/%d/%y")
      return "Yesterday"  
    end
    if Range.new(self.created_at.in_time_zone(Time.zone)-7, self.created_at.in_time_zone(Time.zone) - 1).include?(Time.zone.today)
      day = self.created_at.in_time_zone(Time.zone).strftime("%A")
      return day
    else
      return message_date
    end
  end
end
