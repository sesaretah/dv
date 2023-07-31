$("#article-show").replaceWith(
  "<%= escape_javascript(render(:partial => 'articles/article_publishable', locals: {article: @article})) %>"
);
fireAutoCompleteEvent();
new Noty({
  type: "success",
  theme: "relax",
  timeout: 2000,
  layout: "bottomLeft",
  text: "<%=t :publish_added%>",
}).show();
