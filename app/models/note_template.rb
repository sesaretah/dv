class NoteTemplate < ActiveRecord::Base
    has_many :articles, :through => :noting
    has_many :noting, dependent: :destroy
    belongs_to :user
end
