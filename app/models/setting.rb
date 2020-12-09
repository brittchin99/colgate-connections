class Setting < ApplicationRecord
    belongs_to :profile
    has_one :preference
    accepts_nested_attributes_for :preference

    def to_list(s)
        s.tr('[]', '').tr('"', '').split(',').map(&:strip)
    end
end
