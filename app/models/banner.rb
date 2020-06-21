class Banner < ApplicationRecord
  validates :image_url, presence: true
  # validates :display_by, presence: true

  #カラムの名前をmount_uploaderに指定
  mount_uploader :image_url, BannerimageUploader
end
