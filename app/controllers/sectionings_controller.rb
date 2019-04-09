class SectioningsController < ApplicationController
  def remotec
    @section = Section.find(params[:section_id])
    @section_item = SectionItem.find(params[:section_item_id])
    Sectioning.create(section_id: @section.id, section_item_id: @section_item.id)
  end

  def remoted
    @section = Section.find(params[:section_id])
    @section_item = SectionItem.find(params[:section_item_id])
    @sectioning = Sectioning.where(section_id: @section.id, section_item_id: @section_item.id).first
    if !@sectioning.blank?
      @sectioning.destroy
    end
  end
end
