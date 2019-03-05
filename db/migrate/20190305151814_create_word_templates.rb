class CreateWordTemplates < ActiveRecord::Migration
  def change
    create_table :word_templates do |t|
      t.string :title
      t.integer :workflow_id

      t.timestamps null: false
    end
  end
end
