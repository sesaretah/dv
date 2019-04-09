class Sectioning < ActiveRecord::Base
  belongs_to :section
  belongs_to :section_item
end
