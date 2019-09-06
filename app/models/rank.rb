class Rank < ApplicationRecord
    #カラムの名前をmount_uploaderに指定
    mount_uploader :recordimage, RecordimageUploader
    #名前が入力されていること
    validates :name, presence: true, length: {maximum: 15}
    validates :result, presence: true
    validates :dungeon, presence: true
    validates :movie_or_image, presence: true
    validate :both_true_vali

    # after_save :permit_change_tweet

    def permit_change_tweet
        if self.permission == true
            topurl = "https://shiren2.herokuapp.com"
            twitter = Twitter::REST::Client.new do |config|
                config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
                config.consumer_secret     = ENV['TWITTER_CONSUMER_KEY_SECRET']
                config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
                config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
            end
            time = ""
            if self.result >= 3600 then
                time = (self.result.div(3600).to_s + "時間" + ((self.result.modulo(3600)).div(60)).to_s + "分" + ((self.result.modulo(3600)).modulo(60)).to_s + "秒")
            else
                time = ((self.result.div(60)).to_s + "分" + (self.result.modulo(60)).to_s + "秒")
            end
            sendmessage = "【記録申請通知】\n#{self.dungeon}のランキングが更新されました。\nおめでとうございます！！\nプレイヤー：#{User.find(self.user_id).name}\n記録：#{time}\n詳しくはこちらから→ #{topurl}"
            #twitter.update(sendmessage)
            puts(sendmessage)
        end
    end

    def both_true_vali
        if permission == true && rejection == true
            errors.add(:permission, " はrejectionがTrueの時,Trueには出来ません。")
        end
    end

    #アーカイブのデータを取得する
    def self.GetArchive
        self.group("DATE_FORMAT(created_at, '%Y%m')").order("DATE_FORMAT(created_at, '%Y%m') desc").count
    end

    #データベースからダンジョンに応じたデータを取得
    def self.RankDungeonChoose(dungname)
        return self.where(dungeon: dungname).where(permission: true)
    end

    private
        def movie_or_image
            recordimage.presence or movie.presence
        end
end
