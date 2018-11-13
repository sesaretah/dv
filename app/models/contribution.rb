class Contribution < ActiveRecord::Base
  validates :profile, presence: true
  validates :role, presence: true
  validates :article, presence: true

  belongs_to :role
  belongs_to :duty
  belongs_to :profile
  belongs_to :article
end
