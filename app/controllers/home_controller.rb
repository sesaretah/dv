class HomeController < ApplicationController
  def index
  end

  def advanced_search
    @results = Article.search 'ppp',  :group_by => :profile_ids,  :order_group_by => 'count(*) desc'
  end
end
