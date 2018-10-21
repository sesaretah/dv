ThinkingSphinx::Index.define :profile, :with => :real_time do
  indexes name, :sortable => true
  indexes surename, :sortable => true
end
