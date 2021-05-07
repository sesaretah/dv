<% if @comment.comment_type == 'vote'%>
$("#vote-comments").replaceWith("<%= escape_javascript(render(:partial => 'comments/list', locals: {comments: @article.comments.where(comment_type: 'vote').order('created_at desc') })) %>");
$('#comment_content').val('');
<%else%>
$("#article-show").replaceWith("<%= escape_javascript(render(:partial => 'articles/article_comments', locals: {article: @article, nxt: @next_workflow_states, prv: @previous_workflow_states})) %>");
<%end%>
new Noty({
    type: 'success',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :created_successfully%>'
}).show();
