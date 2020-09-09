class Keyword < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:keyword)
  belongs_to :user

  def self.merge_keyword(keyword_1, keyword_2)
    @taggings = Tagging.where(target_id: keyword_2.id, target_type: "Keyword")
    for tagging in @taggings
      tagging.target_id = keyword_1.id
      tagging.save
    end
    keyword_2.destroy
  end
end
