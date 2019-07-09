$("#messages").replaceWith("<%= escape_javascript(render(:partial => 'messages/message', locals: {message: @message, type: 'inbox', page: 1})) %>");
new Noty({
    type: 'success',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :sent_successfully%>'
}).show();
