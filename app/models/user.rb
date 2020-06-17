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

#パスワード更新処理
  def update_with_password(user_password_params, *options)
    if options.present?
      ActiveSupport::Deprecation.warn <<-DEPRECATION.strip_heredoc
        [Devise] The second argument of `DatabaseAuthenticatable#update_with_password`
        (`options`) is deprecated and it will be removed in the next major version.
        It was added to support a feature deprecated in Rails 4, so you can safely remove it
        from your code.
      DEPRECATION
    end

    current_password = user_password_params.delete(:current_password)

    if user_password_params[:password].blank?
      user_password_params.delete(:password)
      user_password_params.delete(:password_confirmation) if user_password_params[:password_confirmation].blank?
    end

    result = if valid_password?(current_password)
      update(user_password_params, *options)
    else
      assign_attributes(user_password_params, *options)
      valid?
      errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      false
    end

    clean_up_passwords
    result
  end
end
