class Account < ApplicationRecord
    has_many :connections, dependent: :destroy
    has_many :friends, through: :connections
end
