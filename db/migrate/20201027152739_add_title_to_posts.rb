class AddTitleToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :day, :datetime
    add_column :posts, :title, :string
    add_column :posts, :body, :text
    add_column :posts, :address, :string
    add_column :posts, :latitude, :float
    add_column :posts, :longitude, :float
    add_column :posts, :youtube_url, :string
    add_column :posts, :user_id, :integer
  end
end
