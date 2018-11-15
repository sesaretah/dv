$("#article-list").replaceWith("<%= escape_javascript(render(:partial => 'workflow_states/detail', locals: {workflow_state: @workflow_state})) %>");
