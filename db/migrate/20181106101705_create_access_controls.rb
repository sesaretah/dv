class CreateAccessControls < ActiveRecord::Migration
  def change
    create_table :access_controls do |t|
      t.integer :user_id
      t.integer :role_id
      t.integer :view_unrelated_articles
      t.integer :view_article_logs
      t.integer :view_workflow_transactions
      t.integer :create_workflow
      t.integer :alter_article_areas
      t.integer :alter_article_events
      t.integer :alter_article_formats
      t.integer :alter_article_relation_types
      t.integer :alter_article_sources
      t.integer :alter_article_types
      t.integer :alter_keywords
      t.integer :alter_languages
      t.integer :alter_profiles
      t.integer :alter_roles
      t.integer :alter_duties
      t.integer :alter_title_types

      t.timestamps null: false
    end
  end
end
