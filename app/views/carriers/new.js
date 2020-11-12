$("#carrier-list").replaceWith("<%= escape_javascript(render(:partial => 'carriers/form', locals: {workflow: @workflow})) %>");
