$("#article-show").replaceWith("<%= escape_javascript(render(:partial => 'articles/article_workflow_transitions', locals: {article: @article})) %>");
new Noty({
    type: 'success',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :added_successfully%>'
}).show();
