class Carrier < ActiveRecord::Base
  def carry_articles
    return  if self.source_state.blank?
    
    for article in self.source_state.articles
      self.timer.blank? ? timer = 0 : timer = self.timer
      if !article.workflow_transitions.blank?
        transition = article.workflow_transitions.last.created_at
                   else
        transition = article.created_at
                   end
      vote_flag = true
      if self.source_state.is_votable
        case self.voting_condition
        when 0
          vote_flag = true
        when 1
          self.source_state.majority ? vote_flag = true : vote_flag = false
        when 2
          self.source_state.consensus ? vote_flag = true : vote_flag = false
        end
      end
      if (Time.now > transition + timer.hours && vote_flag)
        article.workflow_state_id = self.target_state.id
      article.save
      WorkflowTransition.create!(workflow_id: article.workflow_state.workflow.id,
                                from_state_id: source_state.id, to_state_id: target_state.id, article_id: article.id, message: I18n.t('automatic_transition'), user_id: article.workflow_state.workflow.user_id, role_id: article.workflow_state.workflow.user.current_role_id, transition_type: 1, revision_number: SecureRandom.hex(4))

      self.done = true
        self.save
      end
    end
  end

  def reduce_trial
    if self.trials > 0
      self.trials -= 1
    end
    self.save
  end

  def choose_rule
    rule = self.extract_rules
    self.timer_rule if rule["type"] == "timer" && !self.done
  end

  def extract_rule
    result = {}
    if !self.rules.blank?
      result = JSON.parse(self.rules)
    end
    return result
  end

  def self.carry(r)
    for carrier in self.all
      carrier.carry_articles
    end
  end

  def source_state
    WorkflowState.find_by_id(self.source_workflow_state_id)
  end

  def target_state
    WorkflowState.find_by_id(self.target_workflow_state_id)
  end
end
