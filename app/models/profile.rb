class Profile < ApplicationRecord
  has_many :connections
  has_many :friends, through: :connections
  has_many :friend_requests
  has_many :admirers, through: :friend_requests
  has_many :blockages
  has_many :blockees, through: :blockages
  has_many :notifications
  belongs_to :account
  has_one :setting
  has_one_attached :avatar
  has_many_attached :photos
  after_create :init

  def init
    self.setting = self.create_setting(:notifs => NOTIFICATIONS, :public => PUBLIC, :dating => false)
  end

  def connected_to(profile)
    nil != self.connections.find_by(friend_id: profile.id)
  end
  
  def blocking(profile)
    nil != self.blockages.find_by(blockee_id: profile.id)
  end
  
  def pending_friend_request?(profile)
    nil != self.friend_requests.find_by(friend_id: profile.id)
  end
    
  def has_conversation_with(receiver_id)
    if Conversation.between(self.id, receiver_id).present?
      conversation = Conversation.between(self.id, receiver_id).first
      conversation.has_messages?
    end
  end
  
  def has_unread_conversations
    if Conversation.where('cast(sender_id as text) LIKE ? OR cast(receiver_id as text) LIKE ?', self.id.to_s, self.id.to_s)
      Conversation.where('cast(sender_id as text) LIKE ? OR cast(receiver_id as text) LIKE ?', self.id.to_s, self.id.to_s).each do |c|
        return true if c.has_unread_messages? && c.messages.last.profile!=self
      end
    end
    false
  end
  
  def has_unread_notifications
    if self.notifications.last == nil
      return FALSE
    else
      return !self.notifications.last.read
    end
  end
  
  def should_show(s, profile)
    return self == profile || self.connected_to(profile) || (self != profile and Setting.to_list(profile.setting.public).include? s)
  end
  
  def is_a_match(profile)
    return self.setting.dating && profile.setting.dating && profiles_match(profile)
  end
  
  def profiles_match(profile)
    return (Setting.to_list(profile.setting.preference.pronouns).include?(self.pronouns) and
      Setting.to_list(self.setting.preference.pronouns).include?(profile.pronouns) and
      Setting.to_list(self.setting.preference.class_years).include?(profile.class_year.to_s) and
      Setting.to_list(profile.setting.preference.class_years).include?(self.class_year.to_s))
  end
  
  def get_mutual_connections(profile)
    Profile.where("id IN (SELECT a.friend_id FROM Connections a, Connections b WHERE a.friend_id = b.friend_id AND cast(a.profile_id as text) = ? AND cast(b.profile_id as text) = ?)", self.id.to_s, profile.id.to_s)
  end
  
  def get_accessible_profiles
    profiles = Profile.where("cast(id as text) NOT LIKE ?", self.id.to_s)
    profiles = profiles.where('id NOT IN (SELECT blockee_id FROM blockages WHERE cast(profile_id as text) LIKE ?)', self.id.to_s) if self.blockees.length>0
    blockings = Blockage.where('cast(blockee_id as text) LIKE ?', self.id.to_s)
    profiles = profiles.where('id NOT IN (SELECT profile_id FROM blockages WHERE cast(blockee_id as text) LIKE ?)', self.id.to_s) if blockings.length>0
    return profiles
  end
  
  def suggested_connections
    profiles = get_accessible_profiles
    profiles = profiles.where('id NOT IN (SELECT friend_id FROM connections WHERE cast(profile_id as text) = ?)', self.id.to_s) if self.connections.length>0

    matches = Hash.new
    
    profiles.each do |p|
      points = 0
      if p.class_year == self.class_year
        points += 1
      end
      points += compare(self.majors, p.majors)
      points += compare(self.interests, p.interests)
      if p.minors != nil && self.minors != nil
        points += compare(self.minors, p.minors)
      end
      matches[p.id] = points
    end
    
    if matches.length > 5
      matches = matches.sort_by { |k,v| -v }[0..4].to_h
    end
    suggestions = Profile.none
    matches.each do |key,value|
      suggestions = suggestions.or(profiles.where("cast(id as text) LIKE (?)", key.to_s))
    end
    
    return suggestions
  end
  
  def compare(current, other)
    p1 = current.tr('[]', '').tr('"', '').split(',').map(&:strip)
    p2 = other.tr('[]', '').tr('"', '').split(',').map(&:strip)
    points = 0
    p1.each do |p|
      if p2.include?(p)
        points +=1
      end
    end
    return points
  end
  
  def self.toList(str)
    if str.blank?
      return []
    end
    contents = []
    str.scan(/"([^"]*)"/) { |match| 
      contents.append(match[0])
    }
    if contents.length() == 0
      contents.append(str)
    end
    contents
  end

  validates :first_name, :last_name, :pronouns, :class_year, :majors, :interests, presence: true

  PRONOUNS = ['she/her/hers', 'he/him/his', 'they/them/theirs', 'Other']
  MAJORS = ["Africana and Latin American Studies","Anthropology","Applied Mathematics","Art and Art History","Asian Studies","Astrogeophysics","Astronomy/Physics","Biochemistry","Biology","Chemistry","Chinese","Classical Studies","Computer Science","Computer Science/Mathematics","Economics","Educational Studies","English","Environmental Biology","Environmental Economics","Environmental Geography","Environmental Geology","Environmental Studies","Film and Media Studies","French","Geography","Geology","German","Greek","History","International Relations","Japanese","Latin","Mathematical Economics","Mathematics","Middle Eastern and Islamic Studies","Molecular Biology","Native American Studies","Neuroscience","Peace and Conflict Studies","Philosophy","Philosophy and Religion","Physical Science","Physics","Political Science","Psychological Science","Religion","Russian and Eurasian Studies","Sociology","Spanish","Theater","Women's Studies"]
  MINORS = ["Africana and Latin American Studies","Anthropology","Applied Mathematics","Art and Art History","Asian Studies","Astronomy/Physics","Biology","Chemistry","Chinese","Classical Studies","Computer Science","Creative Writing","Economics","Educational Studies","English","Environmental Studies","Film and Media Studies","French","Geography","Geology","German","History","International Relations","Japanese","Jewish Studies","LGBTQ Studies","Linguistics","Mathematical Systems Biology","Mathematics","Medieval and Renaissance Studies","Middle Eastern and Islamic Studies","Museum Studies","Music","Native American Studies","Peace and Conflict Studies","Philosophy","Physics","Political Science","Psychological Science","Religion","Russian and Eurasian Studies","Sociology","Spanish","Theater","Women's Studies","Writing and Rhetoric"]
  CLASS_YEARS = ["2021", "2022", "2023", "2024"]
  INTERESTS = ["Anime","Baking","Community Service","Cooking","Culture","Dance","E Sports","Fashion","Music","Outdoors & Nature","Performing Arts","Photography","Politics","Pottery","Reading","Sports & Athletics","Travel","Video Games"]
  NOTIFICATIONS = ['New Connections', 'Connection Profile Updates']
  PUBLIC = ['Pronouns', 'Status', 'Interests', 'Photos']
end
