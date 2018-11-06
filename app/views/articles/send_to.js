$("#article-show").replaceWith("<%= escape_javascript(render(:partial => 'articles/article_workflow_states', locals: {article: @article, nxt: @next_workflow_states, prv: @previous_workflow_states})) %>");
new Noty({
    type: 'success',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :sent_successfully%>'
}).show();
