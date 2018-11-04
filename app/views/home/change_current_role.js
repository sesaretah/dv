$("#current_role").replaceWith("<%= escape_javascript(render(:partial => 'home/current_role')) %>");
location.reload();
new Noty({
    type: 'success',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :role_changed_successfully%>'
}).show();
