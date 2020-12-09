class Setting < ApplicationRecord
    belongs_to :profile
    
    def to_list(s)
        s.tr('[]', '').tr('"', '').split(',').map(&:strip)
    end
end
