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
  belongs_to :access_group

  belongs_to :workflow_state
  has_many :workflow_transitions
  has_many :uploads, :as => :uploadable, :dependent => :destroy

  has_many :publishers, :through => :publications
  has_many :publications, dependent: :destroy

  def start_section
    if !self.workflow_state.blank? && !self.workflow_state.workflow.blank? && !self.workflow_state.workflow.sections.blank?
      @section = self.workflow_state.workflow.sections.first.id.to_s
    else
      @section = ''
    end
  end

  def next_section(id)
    if !self.workflow_state.blank? && !self.workflow_state.workflow.blank? && !self.workflow_state.workflow.sections.where("id > ?", id).blank?
      @section = self.workflow_state.workflow.sections.where("id > ?", id).first.id.to_s
    else
      @section = nil
    end
  end

  def keywords
    @taggings = Tagging.where(taggable_id: self.id, taggable_type: 'Article', target_type: 'Keyword')
    @keywords = []
    @keyword_ids = []
    for tagging in @taggings
      @keyword = Keyword.find_by_id(tagging.target_id)
      if !@keyword.blank?
        @keyword_ids << @keyword.id
        @keywords << { 'title' => @keyword.title, 'id' => @keyword.id}
      end
    end
    if @keywords.blank?
      @keywords = ''
    end
    if @keyword_ids.blank?
      @keyword_ids = ''
    end
    return {keywords: @keywords, keyword_ids: @keyword_ids}
  end

  def other_title

  end
end
