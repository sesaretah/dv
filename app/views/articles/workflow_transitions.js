$("#article-show").replaceWith("<%= escape_javascript(render(:partial => 'articles/article_workflow_transitions', locals: {article: @article})) %>");
