class Account < ApplicationRecord
  has_many :connections
  has_many :friends, through: :connections

  def friendships
    self.connections
  end
  
  def connected_to(account)
    connected = false
    self.connections.each do |c|
      if (c.friend == account) 
        connected = true
      end
    end
    connected
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :first_name, :last_name, :email, :password, :pronouns, :class_year, :majors, :interests, presence: true
  validates :email, format: { with: /\A(.+)@colgate\.edu\z/i, message: "must contain @colgate.edu"},
            uniqueness: { case_sensitive: false },
            length: { minimum: 6, maximum: 254 }      

  PRONOUNS = ['she/her/hers', 'he/him/his', 'they/them/theirs', 'Other']
  MAJORS = ["Africana and Latin American Studies","Anthropology","Applied Mathematics","Art and Art History","Asian Studies","Astrogeophysics","Astronomy/Physics","Biochemistry","Biology","Chemistry","Chinese","Classical Studies","Computer Science","Computer Science/Mathematics","Creative Writing","Economics","Educational Studies","English","Environmental Biology","Environmental Economics","Environmental Geography","Environmental Geology","Environmental Studies","Film and Media Studies","French","Geography","Geology","German","Greek","History","International Relations","Japanese","Jewish Studies","Latin","LGBTQ Studies","Linguistics","Mathematical Economics","Mathematical Systems Biology","Mathematics","Medieval and Renaissance Studies","Middle Eastern and Islamic Studies","Molecular Biology","Museum Studies","Music","Native American Studies","Neuroscience","Peace and Conflict Studies","Philosophy","Philosophy and Religion","Physical Science","Physics","Political Science","Psychological Science","Religion","Russian and Eurasian Studies","Sociology","Spanish","Theater","Women's Studies","Writing and Rhetoric"]
  CLASS_YEARS = ["2021", "2022", "2023", "2024"]
  INTERESTS = ["Sports and Athletics", "Community Service", "Performing Arts", "Dance", "Anime", "Video Games"]
end
