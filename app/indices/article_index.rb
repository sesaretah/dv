ThinkingSphinx::Index.define :article, :with => :real_time do
  indexes content
  indexes abstract
  indexes title
  indexes document_contents

  has article_source_ids, :type => :integer, :multi => true
  has article_area_ids, :type => :integer, :multi => true
  has article_format_ids, type: :integer, :multi => true
  has article_type_ids, type: :integer, :multi => true
  has language_ids, type: :integer, :multi => true
  has profile_ids, type: :integer, :multi => true
end
