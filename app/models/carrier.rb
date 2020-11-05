class Carrier < ActiveRecord::Base
    
    def timer_rule
        rule = self.extract_rules
        for article in self.source_state.articles
            if (Time.now > article.workflow_transitions.last.created_at + rule['hours'].hours)
                article.workflow_state_id = self.target_state.id
                article.save
                self.done = true
                self.save
            end
        end
    end

    def choose_rule
        rule = self.extract_rules
        self.timer_rule if rule['type'] == 'timer' && !self.done
    end

    def extract_rule
        result = {}
        if !self.rules.blank?
            result = JSON.parse(self.rules)
        end
        return result
    end

    def source_state
        WorkflowState.find(self.source_workflow_state_id)
    end

    def target_state
        WorkflowState.find(self.target_workflow_state_id)
    end
end
