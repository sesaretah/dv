$("#article-show").replaceWith("<%= escape_javascript(render(:partial => 'articles/article_comments', locals: {article: @article})) %>");
