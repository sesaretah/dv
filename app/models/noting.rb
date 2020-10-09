class Noting < ActiveRecord::Base
    belongs_to :article
    belongs_to :note_template
end
