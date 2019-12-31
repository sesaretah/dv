class RoleAccess < ActiveRecord::Base
  belongs_to :role
  belongs_to :access_group
end
