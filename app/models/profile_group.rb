class ProfileGroup < ActiveRecord::Base
  belongs_to :user

  has_many :profiles, :through => :profile_groupings
  has_many :profile_groupings, dependent: :destroy
end
