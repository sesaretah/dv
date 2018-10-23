class AddArticleRelationTypeIdToKinship < ActiveRecord::Migration
  def change
    add_column :kinships, :article_relation_type_id, :integer
  end
end
