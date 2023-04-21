class CreateCreateContentDtos < ActiveRecord::Migration[7.0]
  def change
    create_table :create_content_dtos do |t|
      t.string :type
      t.string :title
      t.string :end_date
      t.string :start_date
      t.string :image
      t.string :body
      t.string :sites, array: true, default: []
      t.string :creation_tme
      t.string :author

      t.timestamps
    end
  end
end
