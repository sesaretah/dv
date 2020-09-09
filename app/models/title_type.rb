class TitleType < ActiveRecord::Base
  has_many :articles, :through => :titlings
  has_many :titlings, dependent: :destroy
  belongs_to :user

  def self.merge_title_type(title_type_1, title_type_2)
    @titlings = title_type_2.titlings
    for titling in @titlings
      titling.title_type_id = title_type_1.id
      titling.save
    end
  end
end
