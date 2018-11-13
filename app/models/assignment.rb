class Assignment < ActiveRecord::Base
  validates :user, presence: true
  validates :role, presence: true

  belongs_to :user
  belongs_to :role

end
