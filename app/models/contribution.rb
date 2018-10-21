class Contribution < ActiveRecord::Base
  belongs_to :role
  belongs_to :duty
  belongs_to :profile
end
