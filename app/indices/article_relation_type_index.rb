ThinkingSphinx::Index.define :article_relation_type, :with => :real_time do
  indexes title, :sortable => true
end
