class AddArticleIdIndexes < ActiveRecord::Migration
  def change
    add_index :areaings, :article_id
    add_index :contributions, :article_id
    add_index :datings, :article_id
    add_index :formatings, :article_id
    add_index :involvements, :article_id
    add_index :kinships, :article_id
    add_index :originatings, :article_id
    add_index :publications, :article_id
    add_index :speakings, :article_id
    
    add_index :titlings, :article_id
    add_index :typings, :article_id
    add_index :workflow_transitions, :article_id
  end
end
