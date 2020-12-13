class Notification < ApplicationRecord
    belongs_to :profile, class_name: "Profile"
    belongs_to :updater, class_name: "Profile"
    
    def notif_time
        created_at.in_time_zone("Eastern Time (US & Canada)").strftime("%m/%d/%y at %l:%M %p")
    end
    
    def body
        if self.category == 'accept'
            return self.updater.first_name + ' ' + self.updater.last_name + ' accepted your friend request. You are now connected!'
        elsif self.category == 'photos'
            return self.updater.first_name + ' ' + self.updater.last_name + ' uploaded a new photo.'
        else
            return self.updater.first_name + ' ' + self.updater.last_name + ' updated their ' + self.category + '.'
        end        
    end
    
    CATEGORY = ['accept', 'status', 'majors', 'minors', 'interests', 'photos']
end
