class AddUploadIdToUploadHistory < ActiveRecord::Migration
  def change
    add_column :upload_histories, :upload_id, :integer
  end
end
