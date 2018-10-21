$("#artcile_datings_form").replaceWith("<%= escape_javascript(render(:partial => 'datings/remote_form', locals: {article: @article, dating: @dating})) %>");
new Noty({
    type: 'info',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :now_you_can_edit%>'
}).show();
