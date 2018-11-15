class Article < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:article)

  has_many :datings

  has_many :article_events, :through => :datings
  has_many :datings, dependent: :destroy

  has_many :article_types, :through => :typings
  has_many :typings, dependent: :destroy

  has_many :article_areas, :through => :areaings
  has_many :areaings, dependent: :destroy

  has_many :languages, :through => :speakings
  has_many :speakings, dependent: :destroy

  has_many :article_formats, :through => :formatings
  has_many :formatings, dependent: :destroy

  has_many :roles, :through => :contributions
  has_many :duties, :through => :contributions
  has_many :profiles, :through => :contributions
  has_many :contributions, dependent: :destroy

  has_many :kinships, dependent: :destroy
  has_many :kins, :through => :kinships
  has_many :inverse_kinships, :class_name => "Kinship", :foreign_key => "kin_id", dependent: :destroy
  has_many :inverse_kins, :through => :inverse_kinships, :source => :article

  has_many :article_relation_types, :through => :kinships
  has_many :kinships, dependent: :destroy

  has_many :article_sources, :through => :originatings
  has_many :originatings, dependent: :destroy

  has_many :title_types, :through => :titlings
  has_many :titlings, dependent: :destroy

  has_many :taggings, :as => :taggable, :dependent => :destroy

  has_many :comments, :as => :commentable, :dependent => :destroy

  has_many :article_histories
  
  belongs_to :content_template

  belongs_to :workflow_state
end
