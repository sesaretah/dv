<%if @contribution.errors.blank?%>
$("#article_contributions_list").replaceWith("<%= escape_javascript(render(:partial => 'contributions/list', locals: {article: @article})) %>");
$("#article_contributions_form").replaceWith("<%= escape_javascript(render(:partial => 'contributions/remote_form', locals: {article: @article, contribution: Contribution.new})) %>");
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
    timeout: 3000,
    layout: 'bottomLeft',
    text: '<%=t @contribution.errors.full_messages%>'
}).show();
<%end%>
