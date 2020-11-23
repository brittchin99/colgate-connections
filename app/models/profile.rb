class Profile < ApplicationRecord
  has_many :connections
  has_many :friends, through: :connections
  has_many :friend_requests
  has_many :admirers, through: :friend_requests
  belongs_to :account
  has_one_attached :avatar
  has_many_attached :photos

  def connected_to(profile)
    nil != self.connections.find_by(friend_id: profile.id)
  end
  
  def pending_friend_request?(profile)
    nil != self.friend_requests.find_by(friend_id: profile.id)
  end
    
  def has_conversation_with(account_id)
    true
    # c = Conversation.where("sender_id = ? AND receiver_id = ?
    # OR receiver_id = ? AND sender_id = ?", self.id, account_id, account_id, self.id)
    
    # c.nil?
  end
  
  def toList(str)
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
end
