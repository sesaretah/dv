class ProfileGrouping < ActiveRecord::Base
    belongs_to :profile
    belongs_to :profile_group
end
