$("#archive").replaceWith("<%= escape_javascript(render(:partial => 'articles/article_archive', locals: {article: @article})) %>");
