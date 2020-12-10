class Profile < ApplicationRecord
  has_many :connections
  has_many :friends, through: :connections
  has_many :friend_requests
  has_many :admirers, through: :friend_requests
  has_many :blockages
  has_many :blockees, through: :blockages
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
      @conversation = Conversation.between(self.id, receiver_id).first
      @conversation.has_messages?
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
    Profile.where("id IN (SELECT a.friend_id FROM Connections a, Connections b WHERE a.friend_id = b.friend_id AND a.profile_id = ? AND b.profile_id = ?)", self.id, profile.id)
  end
  
  def suggested_connections
    profiles = Profile.where("id NOT LIKE ?", self.id).where('id NOT IN (SELECT friend_id FROM connections WHERE profile_id = ?)', self.id)
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
    
    matches.each do |key,value|
      profiles = profiles.or(profiles.where("id LIKE (?)", key))
    end
    return profiles
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
  MAJORS = ["Africana and Latin American Studies","Anthropology","Applied Mathematics","Art and Art History","Asian Studies","Astrogeophysics","Astronomy/Physics","Biochemistry","Biology","Chemistry","Chinese","Classical Studies","Computer Science","Computer Science/Mathematics","Creative Writing","Economics","Educational Studies","English","Environmental Biology","Environmental Economics","Environmental Geography","Environmental Geology","Environmental Studies","Film and Media Studies","French","Geography","Geology","German","Greek","History","International Relations","Japanese","Jewish Studies","Latin","LGBTQ Studies","Linguistics","Mathematical Economics","Mathematical Systems Biology","Mathematics","Medieval and Renaissance Studies","Middle Eastern and Islamic Studies","Molecular Biology","Museum Studies","Music","Native American Studies","Neuroscience","Peace and Conflict Studies","Philosophy","Philosophy and Religion","Physical Science","Physics","Political Science","Psychological Science","Religion","Russian and Eurasian Studies","Sociology","Spanish","Theater","Women's Studies","Writing and Rhetoric"]
  CLASS_YEARS = ["2021", "2022", "2023", "2024"]
  INTERESTS = ["Sports and Athletics", "Community Service", "Performing Arts", "Dance", "Anime", "Video Games"]
  NOTIFICATIONS = ['New Connections', 'Connection Profile Updates']
  PUBLIC = ['Pronouns', 'Status', 'Interests', 'Photos']
end
