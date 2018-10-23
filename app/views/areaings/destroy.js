$("#article_areaings_list").replaceWith("<%= escape_javascript(render(:partial => 'areaings/list', locals: {article: @article})) %>");
$("#article_areaings_form").replaceWith("<%= escape_javascript(render(:partial => 'areaings/remote_form', locals: {article: @article, areaing: Areaing.new})) %>");
new Noty({
    type: 'error',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :destroyed_successfully%>'
}).show();
