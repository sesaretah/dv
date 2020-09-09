class Assignment < ActiveRecord::Base
  validates :user, presence: true
  validates :role, presence: true

  belongs_to :user
  belongs_to :role

  before_save :check_duplicate

  def check_duplicate
    assigned = Assignment.where(user_id: self.user_id, role_id: self.role_id).first
    if !assigned.blank?
      false
    else
      true
    end
  end

end
