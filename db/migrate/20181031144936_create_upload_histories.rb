class CreateUploadHistories < ActiveRecord::Migration
  def change
    create_table :upload_histories do |t|
      t.string :uploadable_type
      t.integer :uploadable_id
      t.string :token
      t.string :attachment_type
      t.string :revision_number
      t.integer :user_id
      t.integer :workflow_transition_id
      t.integer :speaking_id

      t.timestamps null: false
    end
  end
end
