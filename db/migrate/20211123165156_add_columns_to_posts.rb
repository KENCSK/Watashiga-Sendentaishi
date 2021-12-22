class AddColumnsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :post_image_filename, :string
    add_column :posts, :post_image_size, :string
    add_column :posts, :post_image_content_type, :string
    add_column :posts, :latitude, :float
    add_column :posts, :longitude, :float
  end
end
