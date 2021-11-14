class AddBiographyProfileImageIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :biography, :text
    add_column :users, :profile_image_id, :text
  end
end
