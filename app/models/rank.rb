class Rank < ApplicationRecord
    belongs_to :user, optional: true
    #カラムの名前をmount_uploaderに指定
    mount_uploader :recordimage, RecordimageUploader
    #名前が入力されていること
    validates :name, presence: true, length: {maximum: 15}
    validates :result, presence: true
    validates :dungeon, presence: true
    validates :movie_or_image, presence: true
    validate :both_true_vali
    validate :no_reject_message

    after_save :permit_change

    def permit_change
        if self.permission == true
            #TweetNewRecord
            SendDiscordWebHook(self,ENV['DISCORD_WEBHOOK_ALL'],"ランキングが更新されました！！")
        end
    end

    def TweetNewRecord
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

    def SendDiscordWebHook(rank,webhook,message)
        #PostまたはGet先のURL
        uri = URI(webhook)
        #Net::HTTPのインスタンスを生成
        https = Net::HTTP.new(uri.host, uri.port)
        #ssl(https)を利用する場合はtrueに
        https.use_ssl = true
        https.verify_mode = OpenSSL::SSL::VERIFY_PEER
        req = Net::HTTP::Post.new(uri.path)

        #リクエストヘッダ
        req['Content-Type'] = 'application/json'

        #送りたいデータを格納
        topurl = "https://shiren2.herokuapp.com"
        botname = "記録通知くん"
        boticon = ENV['DISCORD_DEFAULTICON']
        usericon = ENV['DISCORD_DEFAULTICON']
        if rank.result >= 3600 then
            time = rank.result.div(3600).to_s + "時間" + ((rank.result.modulo(3600)).div(60)).to_s + "分" + ((rank.result.modulo(3600)).modulo(60)).to_s + "秒"
        else
            time =(rank.result.div(60)).to_s + "分" + (rank.result.modulo(60)).to_s + "秒"
        end
        if rank.user_id != nil
            user = User.find(rank.user_id)
            if user.icon.url != nil && user.icon.url != ""
                usericon = user.icon.url
            end
        end
        auther = {"name": rank.name}
        if rank.user_id != nil
            auther["url"] = "#{topurl}/user/#{rank.user_id}"
        end
        auther["icon_url"] = boticon

        sendjson = {
            'username': botname,
            "avatar_url": usericon,
            'content': message,
            "embeds": [
            {
                "url": "#{topurl}/admin",
                "color": 5620992,
                "author": auther,
                "fields": [
                    {
                        "name": "ダンジョン",
                        "value": rank.dungeon,
                    },
                    {
                        "name": "記録",
                        "value": time,
                    }
                ]
            }]
            }
        req.body = sendjson.to_json

        #レスポンスデータの受け取り
        result = https.request(req)
    end

    def no_reject_message
        if rejection == true && ( rejectioncomment == "" || rejectioncomment == nil )
            errors.add(:rejectioncomment, "コメントがありません")
        end
    end

    # permissionとrejectionが両方Trueの時にエラーとする
    def both_true_vali
        if permission == true && rejection == true
            errors.add(:permission, "rejectionがTrueです")
            errors.add(:rejection, "permissionがTrueです")
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
