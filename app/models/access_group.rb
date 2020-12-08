class AccessGroup < ActiveRecord::Base

  after_save ThinkingSphinx::RealTime.callback_for(:access_group)
  has_many :articles
  belongs_to :user

  has_many :roles, :through => :role_accesses
  has_many :role_accesses, dependent: :destroy

  has_many :articles, :through => :access_groupings
  has_many :access_groupings, dependent: :destroy

  def self.merge_access_group(access_group_1, access_group_2)
    @role_accesses = access_group_2.role_accesses
    for role_access in @role_accesses
      role_access.access_group_id = access_group_1.id
      role_access.save
    end
  end
end
