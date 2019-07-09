$("#messages").replaceWith("<%= escape_javascript(render(:partial => 'messages/list', locals: {messages: @messages, type: @type})) %>");
