$("#carrier-list").replaceWith("<%= escape_javascript(render(:partial => 'carriers/list', locals: {workflow: @workflow, carriers: @carriers})) %>");
