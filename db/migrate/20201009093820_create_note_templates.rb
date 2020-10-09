class CreateNoteTemplates < ActiveRecord::Migration
  def change
    create_table :note_templates do |t|
      t.string :title
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
