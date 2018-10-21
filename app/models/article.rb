class Article < ActiveRecord::Base
  has_many :datings

  has_many :article_events, :through => :datings
  has_many :datings, dependent: :destroy

  has_many :article_types, :through => :typings
  has_many :typings, dependent: :destroy

  has_many :article_areas, :through => :areaings
  has_many :areaings, dependent: :destroy

  has_many :languages, :through => :speakings
  has_many :speakings, dependent: :destroy

  has_many :article_fromats, :through => :formatings
  has_many :formatings, dependent: :destroy

  has_many :roles, :through => :contributions
  has_many :duties, :through => :contributions
  has_many :profiles, :through => :contributions
  has_many :contributions, dependent: :destroy
end
