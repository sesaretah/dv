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
      #articles = self.find_by_sql("SELECT  * FROM `articles` INNER JOIN `workflow_transitions` ON `workflow_transitions`.`article_id` = `articles`.`id` WHERE (workflow_state_id in (#{workflow_state_ids.join(",")}) and #{archived}) GROUP BY articles.id ORDER BY workflow_transitions.created_at desc") if order == "coming DESC"
      #articles = self.find_by_sql("SELECT * FROM `articles` INNER JOIN `workflow_transitions` ON `workflow_transitions`.`article_id` = `articles`.`id` WHERE (workflow_state_id in (#{workflow_state_ids.join(",")}) and #{archived}) GROUP BY articles.id ORDER BY workflow_transitions.created_at asc", workflow_state_ids) if order == "coming ASC"
      articles = self.where("workflow_state_id in (?) and #{archived}", workflow_state_ids) #if order == "coming ASC"
      #articles = self.where("workflow_state_id in (?)  and #{archived}", workflow_state_ids) if order == "coming DESC"
      last_transitions = []
      for article in articles
        if !article.workflow_transitions.last.blank?
          last_transitions << { id: article.id, transition_id: article.workflow_transitions.last.id, time: article.workflow_transitions.last.created_at }
        else
          last_transitions << { id: article.id, transition_id: nil, time: Time.now }
        end
      end
      if order == "coming ASC"
        last_transitions = last_transitions.sort_by { |hsh| hsh[:time] }
      else
        last_transitions = last_transitions.sort_by { |hsh| hsh[:time] }.reverse
      end
      articles = []
      for last_transition in last_transitions
        p "&&&&&"
        p last_transition
        if !last_transition[:transition_id].blank?
          transition = WorkflowTransition.find(last_transition[:transition_id])
          articles << transition.article
        else
          articles << Article.find(last_transition[:id])
        end
      end
    else
      articles = self.where("workflow_state_id in (?)  and #{archived}", workflow_state_ids).order(order)
    end
    return articles
  end

  def other_title
  end

  def make_a_copy(target_state_id, user)
      @new_article = Article.create(title: self.title, abstract: self.abstract, content:self.content, url: self.url, document_contents: self.document_contents, content_wo_tags: self.content_wo_tags, workflow_state_id: target_state_id, slug: SecureRandom.hex(4))
      @taggings = Tagging.where(taggable_type: 'Article', taggable_id: self.id, target_type: 'Keyword')
      for t in @taggings
        Tagging.where(taggable_type: 'Article', taggable_id: @new_article.id, target_id: t.target_id ,target_type: 'Keyword')
      end
      @article_relation_type = ArticleRelationType.where(title: 'ارجاع شده از:').first
      if !@article_relation_type.blank?
        Kinship.create(kin_id: self.id, article_id: @new_article.id, user_id: user.id, article_relation_type_id: @article_relation_type.id)
      end
      
      typings = Typing.where(article_id: self.id)
      for typing in typings
        Typing.create(article_type_id: typing.article_type_id , article_id: @new_article.id)
      end

      speakings = Speaking.where(article_id: self.id)
      for speaking in speakings
        Speaking.create(language_id: speaking.language_id , article_id: @new_article.id)
      end

      formatings = Formating.where(article_id: self.id)
      for formating in formatings
        Formating.create(article_format_id: formating.article_format_id , article_id: @new_article.id)
      end

      originatings = Originating.where(article_id: self.id)
      for originating in originatings
        Originating.create(article_source_id: originating.article_source_id , article_id: @new_article.id)
      end


      areaings = Areaing.where(article_id: self.id)
      for areaing in areaings
        Areaing.create(article_area_id: areaing.article_area_id , article_id: @new_article.id)
      end
      
      #@uploads = Upload.where(uploadable_type: 'Article', uploadable_id: self.id)
      for upload in Upload.where(uploadable_type: 'Article', uploadable_id: self.id)
        new_upload = Upload.create(uploadable_type: 'Article', uploadable_id: @new_article.id, attachment_type: "article_citation" , user_id: upload.user_id ,title: upload.title, detail: upload.detail)
        new_upload.attachment =  upload.attachment
        new_upload.save
      end

  end

  def self.get_from_rtis(personnel_code, workflow_state_id)
    query = {
      "type" => "article",
    }
    headers = {
      "Authorization" => "Token 4a9b1de1dafb75406eed1ac19d3d74ed740c7a5c",
    }

    result = HTTParty.get(
      "http://rtis2.ut.ac.ir/api/faculty/#{personnel_code}/export?",
      :query => query,
      :headers => headers,
    )
    #Article.where(workflow_state_id: 152).destroy_all

    results = result.parsed_response
    for result in results
      # title
      if !result["paper_title_fa"].blank?
        title =  UnicodeFixer.fix(result["paper_title_fa"])
        other_title =  UnicodeFixer.fix(result["paper_title_en"])
      else
        other_title =  UnicodeFixer.fix(result["paper_title_fa"])
        title =  UnicodeFixer.fix(result["paper_title_en"])
      end
      if !result["paper_web_address"].blank? && result["paper_web_address"].length < 250
        url = result["paper_web_address"]
      else
        url = ""
      end

      article = Article.create(title: title, url: url, workflow_state_id: workflow_state_id, slug: SecureRandom.hex(4), external_id:result["id"] )
      if !other_title.blank?
        Titling.create(title_type_id: TitleType.first.id, article_id: article.id, content: other_title)
      end

      Dating.create(article_id: article.id, article_event_id: 5, event_date: Date.parse(result["publication_date"]))
      language = 1
      language = 2 if result["language_type"] == "انگلیسی"
      Speaking.create(article_id: article.id, language_id: language)
      
      # Publication
      publisher = Publisher.where(title:  UnicodeFixer.fix(result["journal_name"]["title_en"])).first
      if publisher.blank?
        publisher = Publisher.create(title:  UnicodeFixer.fix(result["journal_name"]["title_en"]))
      end
      if !result["publication_country"].blank? && !result["publication_country"]["name_fa"].blank?
        location = Location.where(title:  UnicodeFixer.fix(result["publication_country"]["name_fa"])).first
        if location.blank?
          location = Location.create(title:  UnicodeFixer.fix(result["publication_country"]["name_fa"]))
        end
      end

      if location.blank?
        Publication.create(article_id: article.id, publisher_id: publisher.id, pp: "vol " + result["period_volume"] + "no. " + result["journal_number"] + "pp. " + result["page_number"])
      else
        Publication.create(article_id: article.id, publisher_id: publisher.id, location_id: location.id, pp: "vol " + result["period_volume"] + "no. " + result["journal_number"] + "pp. " + result["page_number"])
      end

      # Contributors
      role = Role.where(title: 'پدیدآور').first
      if role.blank?
        role = Role.create(title: 'پدیدآور')
      end

      if !result["contributors"].blank?
        p result["contributors"]
        for item in result["contributors"]
          p item 
          if !item["profile"]["personnel_code"].blank?
            profile = Profile.where(personnel_code: item["profile"]["personnel_code"]).first
            if profile.blank?
              profile = Profile.create(name: UnicodeFixer.fix(item["profile"]["first_name_fa"]), surename: UnicodeFixer.fix(item["profile"]["last_name_fa"]), personnel_code: item["profile"]["personnel_code"])
            end
            Contribution.create(profile_id: profile.id, article_id: article.id, role_id: role.id)
          end          
        end
      end
    end
  end
end
