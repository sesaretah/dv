class Publisher < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:publisher)
  has_many :articles, :through => :publications
  has_many :publications, dependent: :destroy
  has_many :publish_sources, dependent: :destroy

  belongs_to :user

  def self.merge_publisher(publisher_1, publisher_2)
    @publications = publisher_2.publications
    for publication in @publications
        publication.publisher_id = publisher_1.id
        publication.save
    end
  end

end
