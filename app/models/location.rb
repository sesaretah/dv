class Location < ActiveRecord::Base
  has_many :articles, :through => :publications
  has_many :publications, dependent: :destroy
  belongs_to :user
end
