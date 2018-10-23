ThinkingSphinx::Index.define :article, :with => :real_time do
  indexes content
  indexes title
  indexes document_contents
end
