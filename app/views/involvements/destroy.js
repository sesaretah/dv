$("#article_involvements_list").replaceWith("<%= escape_javascript(render(:partial => 'involvements/list', locals: {article: @article})) %>");
$("#article_involvements_form").replaceWith("<%= escape_javascript(render(:partial => 'involvements/remote_form', locals: {article: @article, involvement: Involvement.new})) %>");
new Noty({
    type: 'error',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :destroyed_successfully%>'
}).show();
