$("#article_kinships_list").replaceWith("<%= escape_javascript(render(:partial => 'kinships/list', locals: {article: @article})) %>");
$("#article_kinships_form").replaceWith("<%= escape_javascript(render(:partial => 'kinships/remote_form', locals: {article: @article, kinship: Kinship.new})) %>");
new Noty({
    type: 'error',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :destroyed_successfully%>'
}).show();
