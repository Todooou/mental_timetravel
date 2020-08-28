class Post < ApplicationRecord
mount_uploader :picture, PictureUploader
validates :day, presence: true
geocoded_by :address
after_validation :geocode, if: :address_changed?
belongs_to :user
end


