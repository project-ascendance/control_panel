class RenameTypeAttribute < ActiveRecord::Migration[7.0]
  def change
    rename_column :create_content_dtos, :type, :content_type
  end
end
