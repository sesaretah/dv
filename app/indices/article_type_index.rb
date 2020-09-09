ThinkingSphinx::Index.define :article_type, :with => :real_time do
  indexes title, :sortable => true
end
