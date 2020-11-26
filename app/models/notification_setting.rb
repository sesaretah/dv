class NotificationSetting < ActiveRecord::Base
    def self.check(user_id, type)
        setting = self.where(user_id: user_id, "#{type}" => true ).first
        if setting.blank? 
            return false 
        else 
            return true
        end
    end
end
