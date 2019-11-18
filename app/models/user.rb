class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :icon, IconUploader
  has_many :ranks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
  validates :name, presence: true, uniqueness: true, length: {maximum: 15}
  validates :introduction, length: {maximum: 1200}
  validate :niconico_valid
  validate :twitch_valid
  validate :youtube_valid

      # permissionとrejectionが両方Trueの時にエラーとする
  def niconico_valid
    if niconico != "" && niconico != nil
      if !niconico.include?("https://com.nicovideo.jp/community")
        errors.add(:niconico, "コミュニティのURLを指定してください")
      end
    end
  end

  def twitch_valid
    if twitch != "" && twitch != nil
      if !twitch.include?("https://www.twitch.tv")
        errors.add(:twitch, "チャンネルのURLを指定してください")
      end
    end
  end

  def youtube_valid
    if youtube != "" && youtube != nil
      if !youtube.include?("https://www.youtube.com/channel")
        errors.add(:youtube, "のURLを指定してください")
      end
    end
  end

  #登録時にメールアドレスを不要とする
  def email_required?
    false
  end

  def email_changed?
    false
  end

 def will_save_change_to_email?
    false
 end
end
