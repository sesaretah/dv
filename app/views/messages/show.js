$("#messages").replaceWith("<%= escape_javascript(render(:partial => 'messages/message', locals: {message: @message, page: @page, type: @type })) %>");
