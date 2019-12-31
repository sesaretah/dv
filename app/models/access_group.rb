class AccessGroup < ActiveRecord::Base
  has_many :articles
  belongs_to :user

  has_many :roles, :through => :role_accesses
  has_many :role_accesses, dependent: :destroy
end
