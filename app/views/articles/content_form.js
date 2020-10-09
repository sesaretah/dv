$("#content-form").replaceWith("<%= escape_javascript(render(:partial => 'articles/content_form', locals: {article: @article})) %>");
