class ConvertCommentToUtf8mb4 < ActiveRecord::Migration
  def change
    # for each table that will store unicode execute:
    execute "ALTER TABLE comments CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    # for each string/text column with unicode content execute:
    execute "ALTER TABLE comments MODIFY content VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
  end
end
