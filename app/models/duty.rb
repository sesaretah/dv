class Duty < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:duty)
  has_many :articles, :through => :contributions
  has_many :contributions, dependent: :destroy
  belongs_to :user

  def self.merge_duty(duty_1, duty_2)
    @contributions = duty_2.contributions
    for contribution in @contributions
      contribution.duty_id = duty_1.id
      contribution.save
    end
  end

end
