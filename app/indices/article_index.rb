ThinkingSphinx::Index.define :article, :with => :real_time do
  indexes content
  indexes abstract
  indexes title
  indexes document_contents
  indexes content_wo_tags
  indexes notes
  indexes slug
  indexes profiles_fullname

  has article_source_ids, :type => :integer, :multi => true
  has titling_ids, :type => :integer, :multi => true
  has article_area_ids, :type => :integer, :multi => true
  has article_format_ids, type: :integer, :multi => true
  has article_type_ids, type: :integer, :multi => true
  has dating_ids, type: :integer, :multi => true
  has language_ids, type: :integer, :multi => true
  has profile_ids, type: :integer, :multi => true
  has tagging_ids, type: :integer, :multi => true
  has workflow_state_id, type: :integer
  has publish_source_id, type: :integer
  has workflow_state.workflow_id, type: :integer
end
