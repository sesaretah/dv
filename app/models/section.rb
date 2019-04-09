class Section < ActiveRecord::Base
  belongs_to :user
  belongs_to :workflow
  has_many :sectionings, dependent: :destroy
  has_many :section_items, through: :sectionings
end
