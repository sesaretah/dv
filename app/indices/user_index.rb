ThinkingSphinx::Index.define :user, :with => :real_time do
  indexes utid, :sortable => true
  indexes email, :sortable => true
end
