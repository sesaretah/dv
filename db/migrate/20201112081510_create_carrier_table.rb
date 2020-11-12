class CreateCarrierTable < ActiveRecord::Migration
  def change
    create_table :carriers do |t|
      t.integer :source_workflow_state_id
      t.integer :target_workflow_state_id
      t.string :rules
      t.integer :user_id
      t.boolean :done

      t.timestamps null: false
    end
  end
end
