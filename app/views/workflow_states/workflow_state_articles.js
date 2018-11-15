$("#article-show").replaceWith("<%= escape_javascript(render(:partial => 'articles/list_wo_progress', locals: {articles: @articles})) %>");
