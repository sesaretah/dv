$("#mirorr-list").replaceWith("<%= escape_javascript(render(:partial => 'mirorrs/list', locals: {workflow: @workflow, mirorrs: @mirorrs})) %>");
