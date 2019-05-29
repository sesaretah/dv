$("#article_publications_list").replaceWith("<%= escape_javascript(render(:partial => 'publications/list', locals: {article: @article})) %>");
$("#article_publications_form").replaceWith("<%= escape_javascript(render(:partial => 'publications/remote_form', locals: {article: @article, publication: Publication.new})) %>");
new Noty({
    type: 'error',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :destroyed_successfully%>'
}).show();
