$("#article-show").replaceWith("<%= escape_javascript(render(:partial => 'articles/article_publishable', locals: {article: @article})) %>");
fireAutoCompleteEvent();