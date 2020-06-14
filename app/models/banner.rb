class Banner < ApplicationRecord
  validates :image_url, presence: true
  # validates :display_by, presence: true
end
