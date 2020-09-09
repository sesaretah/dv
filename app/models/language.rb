class Language < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:language)
  has_many :articles, :through => :speakings
  has_many :speakings, dependent: :destroy
  belongs_to :user

  def self.merge_language(language_1, language_2)
    @speakings = language_2.speakings
    for speaking in @speakings
      speaking.language_id = language_1.id
      speaking.save
    end
  end

end
