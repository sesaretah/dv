class Language < ActiveRecord::Base
  has_many :articles, :through => :speakings
  has_many :speakings, dependent: :destroy
end
