$("#state_page-list").replaceWith("<%= escape_javascript(render(:partial => 'state_pages/form', locals: {workflow: @workflow, state_page: @state_page})) %>");
