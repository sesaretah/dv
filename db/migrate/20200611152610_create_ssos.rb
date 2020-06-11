class CreateSsos < ActiveRecord::Migration
  def change
    create_table :ssos do |t|
      t.string :utid
      t.string :uuid

      t.timestamps null: false
    end
    add_index :ssos, :uuid
  end
end
