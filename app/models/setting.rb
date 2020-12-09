class Setting < ApplicationRecord
    belongs_to :profile
    has_one :preference
    accepts_nested_attributes_for :preference
    after_create :init

    def init
        self.preference = self.create_preference(:pronouns => [], :class_years => [])
    end

    def to_list(s)
        s.tr('[]', '').tr('"', '').split(',').map(&:strip)
    end
end
