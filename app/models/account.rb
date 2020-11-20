class Account < ApplicationRecord
  has_one :profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates  :email, :password, presence: true
  validates :email, format: { with: /\A(.+)@colgate\.edu\z/i, message: "must contain @colgate.edu"},
            uniqueness: { case_sensitive: false },
            length: { minimum: 6, maximum: 254 }      
end
