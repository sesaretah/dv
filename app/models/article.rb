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

  has_many :publishers, :through => :involvements
  has_many :involvements, dependent: :destroy

  has_many :kinships, dependent: :destroy
  has_many :kins, :through => :kinships
  has_many :inverse_kinships, :class_name => "Kinship", :foreign_key => "kin_id", dependent: :destroy
  has_many :inverse_kins, :through => :inverse_kinships, :source => :article

  has_many :article_relation_types, :through => :kinships
  has_many :kinships, dependent: :destroy

  has_many :access_groupings, dependent: :destroy

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

  has_many :note_templates, :through => :noting
  has_many :noting, dependent: :destroy

  delegate :workflow, :to => :workflow_state, :allow_nil => true
  # def workflow
  #   self.workflow_state.workflow if !self.workflow_state.blank?
  # end

  def start_section
    if !self.workflow_state.blank? && !self.workflow_state.workflow.blank? && !self.workflow_state.workflow.sections.blank?
      @section = self.workflow_state.workflow.sections.first.id.to_s
    else
      @section = ""
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
    @taggings = Tagging.where(taggable_id: self.id, taggable_type: "Article", target_type: "Keyword")
    @keywords = []
    @keyword_ids = []
    for tagging in @taggings
      @keyword = Keyword.find_by_id(tagging.target_id)
      if !@keyword.blank?
        @keyword_ids << @keyword.id
        @keywords << { "title" => @keyword.title, "id" => @keyword.id }
      end
    end
    if @keywords.blank?
      @keywords = ""
    end
    if @keyword_ids.blank?
      @keyword_ids = ""
    end
    return { keywords: @keywords, keyword_ids: @keyword_ids }
  end

  def self.in_dashboard(user, home_setting)
    home_setting.sort.blank? ? order = "created_at" : order = "#{home_setting.sort}"

    archived = "( archived is NULL or archived = 1 or archived = 0 )" if home_setting.archived.blank? || home_setting.archived == 0
    archived = "( archived is NULL or archived = 0 )" if home_setting.archived == -1
    archived = "archived = 1" if home_setting.archived == 1

    home_setting.workflow_state == -1 ? workflow_state_sql = "" : workflow_state_sql = "and id = #{home_setting.workflow_state}"
    home_setting.workflow == -1 ? workflow_sql = "" : workflow_sql = "and workflow_id = #{home_setting.workflow}"
    role_ids = user.roles.pluck(:id)
    workflow_state_ids = WorkflowState.where("role_id in (?) #{workflow_state_sql} #{workflow_sql}", role_ids).pluck(:id)

    if order == "coming ASC" || order == "coming DESC"
      articles = self.find_by_sql("SELECT  * FROM `articles` INNER JOIN `workflow_transitions` ON `workflow_transitions`.`article_id` = `articles`.`id` WHERE (workflow_state_id in (#{workflow_state_ids.join(",")}) and #{archived}) GROUP BY articles.id ORDER BY workflow_transitions.created_at desc") if order == "coming DESC"
      articles = self.find_by_sql("SELECT * FROM `articles` INNER JOIN `workflow_transitions` ON `workflow_transitions`.`article_id` = `articles`.`id` WHERE (workflow_state_id in (#{workflow_state_ids.join(",")}) and #{archived}) GROUP BY articles.id ORDER BY workflow_transitions.created_at asc", workflow_state_ids) if order == "coming ASC"
      #articles = self.where("workflow_state_id in (?) and #{archived}", workflow_state_ids).sort { |obj| obj.workflow_transitions.last.created_at rescue Time.now } if order == "coming ASC"
      #articles = self.where("workflow_state_id in (?)  and #{archived}", workflow_state_ids).sort { |obj| -obj.workflow_transitions.last.created_at rescue Time.now } if order == "coming DESC"

      p "@@@@&&@@@"
      p order
      p workflow_state_ids
      p articles.first.id
    else
      articles = self.where("workflow_state_id in (?)  and #{archived}", workflow_state_ids).order(order)
    end
    return articles
  end

  def other_title
  end
end
