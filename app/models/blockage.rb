class Blockage < ApplicationRecord
    belongs_to :profile, class_name: "Profile"
    belongs_to :blockee, class_name: "Profile"
end
