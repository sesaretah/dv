Rails.application.routes.draw do
  resources :note_templates
  get '/keywords/uniqify' => 'keywords#uniqify'
  
  resources :profile_groups
  resources :involvements
  resources :messages
  resources :publish_sources
  resources :locations
  resources :publishers
  resources :sections
  resources :word_templates
  resources :access_groups
  resources :content_templates
  resources :votes
  resources :votings
  resources :comments
  resources :notifications
  resources :access_controls
  resources :upload_histories
  resources :speaking_histories
  resources :areaing_histories
  resources :originating_histories
  resources :kinship_histories
  resources :contribution_histories
  resources :formating_histories
  resources :typing_histories
  resources :dating_histories
  resources :tagging_histories
  resources :article_histories
  resources :workflow_transitions
  resources :assignments
  resources :workflow_states
  resources :workflows
  resources :taggings
  resources :uploads
  resources :originatings
  resources :kinships
  resources :contributions
  resources :roles
  resources :profiles
  resources :duties
  resources :formatings
  resources :speakings
  resources :languages
  resources :areaings
  resources :typings
  resources :datings
  resources :keywords
  resources :titlings
  resources :title_types
  resources :articles
  resources :article_types
  resources :article_sources
  resources :article_relation_types
  resources :article_formats
  resources :article_events
  resources :section_items
  resources :sections
  resources :publications
  #devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations", sessions: "sessions"}
  devise_scope :user do
    get "/users/service", to: "registrations#service"
    get "/users/cas_login", to: "sessions#cas_login"
  end

  resources :article_areas
  resources :section_items
  resources :profile_groupings

  root to: 'home#search'
  get ':slug' => 'home#index'

  match "/home/advanced_search" => "home#advanced_search", :via => :get
  match "/home/change_current_role" => "home#change_current_role", :via => :get
  match "/home" => "home#index", :via => :get
  match "/home/email_sent" => "home#email_sent", :via => :get
  match "/home/search" => "home#search", :via => :get

  match "/titlings/add_item/:id" => "titlings#add_item", :via => :get

  match "/articles/article_descriptors/:id" => "articles#article_descriptors", :via => :get
  match "/articles/article_related_dates/:id" => "articles#article_related_dates", :via => :get
  match "/articles/article_other_details/:id" => "articles#article_other_details", :via => :get
  match "/articles/article_contributions/:id" => "articles#article_contributions", :via => :get
  match "/articles/article_relations/:id" => "articles#article_relations", :via => :get
  match "/articles/send_to/:id" => "articles#send_to", :via => :get
  match "/articles/refund_to/:id" => "articles#refund_to", :via => :get
  match "/articles/workflow_transitions/:id" => "articles#workflow_transitions", :via => :get
  match "/articles/article_detail/:id" => "articles#article_detail", :via => :get
  match "/articles/article_logs/:id" => "articles#article_logs", :via => :get
  match "/articles/compare/:id" => "articles#compare", :via => :get
  match "/articles/search/:id" => "articles#search", :via => :get
  match "/articles/article_states/:id" => "articles#article_states", :via => :get
  match "/articles/article_comments/:id" => "articles#article_comments", :via => :get
  match "/articles/make_a_copy/:id" => "articles#make_a_copy", :via => :get
  match "/articles/article_publishable/:id" => "articles#article_publishable", :via => :get
  match "/articles/change_access_group/:id" => "articles#change_access_group", :via => :get
  match "/articles/sectioned_form/:id" => "articles#sectioned_form", :via => :get
  match "/articles/title_search/:id" => "articles#title_search", :via => :get
  match "/articles/fixer/:id" => "articles#fixer", :via => :get
  match "/articles/csv_to_db/:id" => "articles#csv_to_db", :via => :get
  match "/articles/csv_to_db_2/:id" => "articles#csv_to_db_2", :via => :get
  match "/articles/upload_indexer/:id" => "articles#upload_indexer", :via => :get
  match "/articles/raw_print/:id" => "articles#raw_print", :via => :get
  match "/articles/content_form/:id" => "articles#content_form", :via => :get
  match "/articles/set_note_template/:id" => "articles#set_note_template", :via => :get
  
  match "/workflows/related_articles/:id" => "workflows#related_articles", :via => :get


  match "/typings/remotec/:id" => "typings#remotec", :via => :get
  match "/typings/remoted/:id" => "typings#remoted", :via => :get

  match "/speakings/remotec/:id" => "speakings#remotec", :via => :get
  match "/speakings/remoted/:id" => "speakings#remoted", :via => :get

  match "/formatings/remotec/:id" => "formatings#remotec", :via => :get
  match "/formatings/remoted/:id" => "formatings#remoted", :via => :get

  match "/keywords/search/:id" => "keywords#search", :via => :get
  match "/roles/search/:id" => "roles#search", :via => :get
  match "/profiles/search/:id" => "profiles#search", :via => :get
  match "/duties/search/:id" => "duties#search", :via => :get
  match "/article_relation_types/search/:id" => "article_relation_types#search", :via => :get

  match "/article_sources/search/:id" => "article_sources#search", :via => :get
  match "/article_areas/search/:id" => "article_areas#search", :via => :get

  match "/uploads/remoted/:id" => "uploads#remoted", :via => :get

  match "/profiles/contributions/:id" => "profiles#contributions", :via => :get
  match "/profiles/profile_details/:id" => "profiles#profile_details", :via => :get
  match "/profiles/cropper/:id" => "profiles#cropper", :via => :get
  match "/profiles/search_in_users/:id" => "profiles#search_in_users", :via => :get


  match "/votes/remotec/:id" => "votes#remotec", :via => :get

  match "/workflow_states/view_remote/:id" => "workflow_states#view_remote", :via => :get
  match "/workflow_states/workflow_state_articles/:id" => "workflow_states#workflow_state_articles", :via => :get
  match "/workflow_states/show_by_node/:id" => "workflow_states#show_by_node", :via => :get

  match "/home/reports" => "home#reports", :via => :get
  match "/home/swap" => "home#swap", :via => :get
  match "/kinships/change_rank/:id" => "kinships#change_rank", :via => :get
  match "/articles/print/:id" => "articles#print", :via => :get

  match "/apis/comments" => "apis#comments_api", :via => :post

  post '/role_accesses', to:'role_accesses#create'
  get '/role_accesses/destroy', to: 'role_accesses#destroy'

  get '/api/login', to: 'api#login'
  get '/api/dashboard', to: 'api#dashboard'
  get '/api/roles', to: 'api#roles'
  get '/api/change_role', to: 'api#change_role'
  get '/api/article/:id', to: 'api#article'

  match "/sectionings/remotec/:id" => "sectionings#remotec", :via => :get
  match "/sectionings/remoted/:id" => "sectionings#remoted", :via => :get

  match "/profiles/mergerer/:id" => "profiles#mergerer", :via => :get
  match "/profiles/merge/:id" => "profiles#merge", :via => :get
  match "/profiles/detach_profile/:id" => "profiles#detach_profile", :via => :get

  match "/publishers/search/:id" => "publishers#search", :via => :get
  match "/publishers/publish_sources/:id" => "publishers#publish_sources", :via => :get


  match "/keywords/mergerer/:id" => "keywords#mergerer", :via => :get
  match "/keywords/merge/:id" => "keywords#merge", :via => :get

  match "/article_areas/mergerer/:id" => "article_areas#mergerer", :via => :get
  match "/article_areas/merge/:id" => "article_areas#merge", :via => :get

  match "/article_events/mergerer/:id" => "article_events#mergerer", :via => :get
  match "/article_events/merge/:id" => "article_events#merge", :via => :get
  match "/article_events/search/:id" => "article_events#search", :via => :get

  match "/article_formats/mergerer/:id" => "article_formats#mergerer", :via => :get
  match "/article_formats/merge/:id" => "article_formats#merge", :via => :get
  match "/article_formats/search/:id" => "article_formats#search", :via => :get

  match "/article_relation_types/mergerer/:id" => "article_relation_types#mergerer", :via => :get
  match "/article_relation_types/merge/:id" => "article_relation_types#merge", :via => :get

  match "/article_sources/mergerer/:id" => "article_sources#mergerer", :via => :get
  match "/article_sources/merge/:id" => "article_sources#merge", :via => :get

  match "/article_types/mergerer/:id" => "article_types#mergerer", :via => :get
  match "/article_types/merge/:id" => "article_types#merge", :via => :get
  match "/article_types/search/:id" => "article_types#search", :via => :get

  match "/languages/mergerer/:id" => "languages#mergerer", :via => :get
  match "/languages/merge/:id" => "languages#merge", :via => :get
  match "/languages/search/:id" => "languages#search", :via => :get

  match "/duties/mergerer/:id" => "duties#mergerer", :via => :get
  match "/duties/merge/:id" => "duties#merge", :via => :get
  match "/duties/search/:id" => "duties#search", :via => :get

  match "/roles/mergerer/:id" => "roles#mergerer", :via => :get
  match "/roles/merge/:id" => "roles#merge", :via => :get
  match "/roles/search/:id" => "roles#search", :via => :get

  match "/title_types/mergerer/:id" => "title_types#mergerer", :via => :get
  match "/title_types/merge/:id" => "title_types#merge", :via => :get
  match "/title_types/search/:id" => "title_types#search", :via => :get

  match "/access_groups/mergerer/:id" => "access_groups#mergerer", :via => :get
  match "/access_groups/merge/:id" => "access_groups#merge", :via => :get
  match "/access_groups/search/:id" => "access_groups#search", :via => :get


  match "/publishers/mergerer/:id" => "publishers#mergerer", :via => :get
  match "/publishers/merge/:id" => "publishers#merge", :via => :get
  match "/publishers/search/:id" => "publishers#search", :via => :get

  match "/publish_sources/mergerer/:id" => "publish_sources#mergerer", :via => :get
  match "/publish_sources/merge/:id" => "publish_sources#merge", :via => :get
  match "/publish_sources/search/:id" => "publish_sources#search", :via => :get

  match "/messages/delete/:id" => "messages#delete", :via => :get
  match "/messages/reply/:id" => "messages#reply", :via => :get
  match "/messages/reply_all/:id" => "messages#reply_all", :via => :get

  match "/profile_groupings/delete/:id" => "profile_groupings#delete", :via => :get


end
