$("#article_workflow_action").replaceWith("<%= escape_javascript(render(:partial => 'articles/workflow_actions', locals: {article: @article})) %>");
new Noty({
    type: 'error',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :refunded%>'
}).show();
