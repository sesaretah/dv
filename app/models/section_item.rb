class SectionItem < ActiveRecord::Base
  belongs_to :user
  has_many :sectionings, dependent: :destroy
  has_many :sections, through: :sectionings
end
