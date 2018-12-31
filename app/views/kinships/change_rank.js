$("#article_kinships_list").replaceWith("<%= escape_javascript(render(:partial => 'kinships/list', locals: {article: @article})) %>");
