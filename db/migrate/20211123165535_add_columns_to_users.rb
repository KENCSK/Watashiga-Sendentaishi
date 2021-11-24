class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_image_filename, :string
    add_column :users, :profile_image_size, :string
    add_column :users, :profile_image_content_type, :string
  end
end
