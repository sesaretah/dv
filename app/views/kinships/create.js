<%if @kinship.errors.blank?%>
$("#article_kinships_list").replaceWith("<%= escape_javascript(render(:partial => 'kinships/list', locals: {article: @article})) %>");
$("#article_kinships_form").replaceWith("<%= escape_javascript(render(:partial => 'kinships/remote_form', locals: {article: @article, kinship: Kinship.new})) %>");
new Noty({
    type: 'success',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :added_successfully%>'
}).show();
<%else%>
new Noty({
    type: 'error',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t @kinship.errors.full_messages%>'
}).show();
<%end%>
