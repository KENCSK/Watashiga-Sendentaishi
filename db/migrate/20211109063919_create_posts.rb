class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :prefecture_id, foreign_key: true
      t.string :title
      t.text :text
      t.text :post_image_id
      t.text :address
      t.timestamps
    end
  end
end
