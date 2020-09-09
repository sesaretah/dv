ThinkingSphinx::Index.define :article_event, :with => :real_time do
  indexes title, :sortable => true
end
