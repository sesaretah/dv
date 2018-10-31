$("#article-show").replaceWith("<%= escape_javascript(render(:partial => 'articles/article_logs', locals: {article: @article, result: @result})) %>");
