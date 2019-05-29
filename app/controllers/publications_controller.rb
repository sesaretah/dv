class PublicationsController < ApplicationController
  def create
    @publication = Publication.create(article_id: params[:article_id], publisher_id: params[:publisher_id], location_id: params[:location_id], pp: params[:pp], publish_source_id: params[:publish_source_id])
    @article = @publication.article
  end

  def destroy
    @publication = Publication.find(params[:id])
    if !@publication.blank?
      @article = @publication.article
      @publication.destroy
    end
  end
end
