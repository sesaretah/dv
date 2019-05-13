class PublicationsController < ApplicationController
  def create
    @publication = Publication.create(article_id: params[:article_id], publisher_id: params[:publisher_id])
  end

  def destroy
    @publication = Publication.destroy
  end
end
