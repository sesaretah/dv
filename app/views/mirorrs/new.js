$("#mirorr-list").replaceWith("<%= escape_javascript(render(:partial => 'mirorrs/form', locals: {workflow: @workflow})) %>");
