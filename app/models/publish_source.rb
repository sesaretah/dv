class PublishSource < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:publish_source)
  belongs_to :publisher
  has_many :articles
  belongs_to :user
  has_many :publications

  def self.merge_publish_source(publish_source_1, publish_source_2)
    @publications = publish_source_2.publications
    for publication in @publications
        publication.publish_source_id = publish_source_1.id
        publication.save
    end
  end
end
