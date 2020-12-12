class Post < ApplicationRecord
    mount_uploader :image1, PictureUploader
    mount_uploader :image2, PictureUploader
    mount_uploader :image3, PictureUploader
    validates :start_time, presence: true
    validates :address, presence: true
    validates :image1, presence:true
    geocoded_by :address
    after_validation :geocode, if: :address_changed?
    belongs_to :user
    has_many :tag_maps, dependent: :destroy
    has_many :tags, through: :tag_maps



    def save_posts(sent_tags)
      current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
      old_tags = current_tags - sent_tags
      new_tags = sent_tags - current_tags

        old_tags.each do |old_name|
          self.tags.delete
          Tag.find_by(tag_name: old_name)
        end

        new_tags.each do |new_name|
          post_tag = Tag.find_or_create_by(tag_name: new_name)
          self.tags << post_tag
        end
    end
end
