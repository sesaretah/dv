class AddTrialUuidToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :trial_uuid, :string
    add_index :articles, :trial_uuid
  end
end
