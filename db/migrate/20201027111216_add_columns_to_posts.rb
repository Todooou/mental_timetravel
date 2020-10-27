class AddColumnsToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :image1, :string
    add_column :posts, :image2, :string
    add_column :posts, :image3, :string
    add_column :posts, :genre, :string
  end
end
