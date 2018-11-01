class TitleType < ActiveRecord::Base
  has_many :articles, :through => :titlings
  has_many :titlings, dependent: :destroy
  belongs_to :user
end
