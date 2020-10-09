$("#article-voices").replaceWith("<%= escape_javascript(render(:partial => 'articles/article_voices', locals: {article: @article})) %>");
