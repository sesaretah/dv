class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile

  has_many :roles, :through => :assignments
  has_many :assignments, dependent: :destroy
  has_many :access_controls
  has_many :content_templates
  has_many :workflows
  has_many :notifications
  has_many :access_groups
  has_many :word_templates
end
