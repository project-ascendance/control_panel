class FixNamingMistakeCreationTme < ActiveRecord::Migration[7.0]
  def change
    rename_column :create_content_dtos, :creation_tme, :creation_time
  end
end
