$("#article-show").replaceWith("<%= escape_javascript(render(:partial => 'articles/article_detail', locals: {article: @article})) %>");
