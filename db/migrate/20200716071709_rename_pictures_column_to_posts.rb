class RenamePicturesColumnToPosts < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :pictures, :picture
  end
end
