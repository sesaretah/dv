Rails.application.routes.draw do
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
  #devise_for :users
  devise_for :users, :controllers => { :passwords => "passwords" }

  resources :article_areas
  root to: 'home#index'

  match "/home/advanced_search" => "home#advanced_search", :via => :get
  match "/home/change_current_role" => "home#change_current_role", :via => :get

  match "/home/email_sent" => "home#email_sent", :via => :get

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

  match "/votes/remotec/:id" => "votes#remotec", :via => :get


end
