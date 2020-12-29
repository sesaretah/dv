class NotificationSetting < ActiveRecord::Base
    def self.check(user_id, type)
        return true if self.okeys(type)
        setting = self.where(user_id: user_id, "#{type}" => true ).first
        if setting.blank?
            return false
        else
            return true
        end
    end

    def self.okeys(type)
      flag = false
      case type
      when 'access_grouping'
        flag = true
      end
      return flag
    end
end
