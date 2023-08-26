$("#article-show").replaceWith(
  "<%= escape_javascript(render(:partial => 'articles/article_publishable', locals: {article: @article})) %>"
);
fireAutoCompleteEvent();
new Noty({
  type: "warning",
  theme: "relax",
  timeout: 12000,
  layout: "bottomLeft",
  text: "<%=t :pdf_being_genereted%>",
}).show();
