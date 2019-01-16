<% if @flag%>
new Noty({
    type: 'success',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :copy_has_been_made%>'
}).show();
<%end%>
<% if !@flag%>
new Noty({
    type: 'error',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :article_already_exists%>'
}).show();
<%end%>
