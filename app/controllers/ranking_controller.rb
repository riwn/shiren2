class RankingController < ApplicationController

    require 'net/https'
    require 'net/https'
    require 'uri'
    ######################################################メソッド########################################################

    #URLからダンジョンの名前を取得
    def getDungeonName(dungeonURLStr)
        if dungeonURLStr == "saihate"
            return "最果てへの道99FTA"
        elsif dungeonURLStr== "well"
            return "カラクロTA"
        elsif dungeonURLStr == "onigashima"
            return "鬼ヶ島ありありTA"
        elsif dungeonURLStr == "shrine"
            return "女王グモ捕獲TA"
        elsif dungeonURLStr == "story"
            return "ストーリーTA"
        else
            return ""
        end
    end

    def getDungeonColor(dungeonURLStr)
        if dungeonURLStr == "saihate"
            return "bg-primary"
        elsif dungeonURLStr== "well"
            return "bg-warning"
        elsif dungeonURLStr == "onigashima"
            return "bg-danger"
        elsif dungeonURLStr == "shrine"
            return "bg-dark"
        elsif dungeonURLStr == "story"
            return "bg-success"
        else
            return ""
        end
    end

    def SendDiscordWebHook(rank)
        #PostまたはGet先のURL
        uri = URI("https://discordapp.com/api/webhooks/591567156739833856/elYIKw1LA60J0KoA45jkytNEPTXPo4YEMQtwyg_TPFu2xK8nb3qaQ7TTPKQAa0V__wbR")
        #Net::HTTPのインスタンスを生成
        https = Net::HTTP.new(uri.host, uri.port)
        #ssl(https)を利用する場合はtrueに
        https.use_ssl = true
        https.verify_mode = OpenSSL::SSL::VERIFY_NONE

        req = Net::HTTP::Post.new(uri.path)

        #リクエストヘッダ
        req['Content-Type'] = 'application/json'

        #送りたいデータを格納
        topurl = "https://localhost:3000"
        botname = "記録通知くん"
        boticon = "https://cdn.discordapp.com/icons/565179762084151296/dcc15d11a9cbbd059d5ad8875953bb91.png?size=128"
        auther = {"name": rank.name}
        if rank.user_id != nil
            auther["url"] = "#{topurl}/user/#{rank.user_id}"
        end
        auther["icon_url"] = boticon

        if rank.result >= 3600 then
            time = rank.result.div(3600).to_s + "時間" + ((rank.result.modulo(3600)).div(60)).to_s + "分" + ((rank.result.modulo(3600)).modulo(60)).to_s + "秒"
        else
            time =(rank.result.div(60)).to_s + "分" + (rank.result.modulo(60)).to_s + "秒"
        end
        message = "新しい記録が申請されました！"
        sendjson = {
            'username': botname,
            "avatar_url": boticon,
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

    ######################################################メソッド終わり######################################################

    PER = 10

    #URLからダンジョンと日付を取得してデータベースから記録も取得
    def dungeon
        #URLからダンジョンを取得
        @dungeonurl = params[:dungeon]
        @dungeonname = getDungeonName(@dungeonurl)
        #不正なURLを入れられたときにTopに戻る処理
        if @dungeonname == ""
            redirect_to "/"
            return
        end

        #選択されたダンジョンの記録のみを抽出
        @ranks = Rank.RankDungeonChoose(@dungeonname)
        #アーカイブを取得(各日付と記録数を取得)
        @archives = @ranks.GetArchive
        if params[:yyyymm] != nil
            if(params[:yyyymm]=~ /^[0-9]+$/)
                @yyyymm = params[:yyyymm]
                year = @yyyymm[0,4].to_i
                month = @yyyymm[4,2].to_i
                season = ""
                if(month == 3 || month == 4|| month == 5)
                    season = " 春期"
                    @ranks = @ranks.where("strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}03' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}04' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}05'")
                elsif(month == 6 || month == 7 || month == 8)
                    season = " 夏期"
                    @ranks = @ranks.where("strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}06' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}07' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}08'")
                elsif(month == 9 || month == 10|| month == 11)
                    season = " 秋期"
                    @ranks = @ranks.where("strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}09' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}10' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}11'")
                elsif(month == 12 || month == 1|| month == 2)
                    season = " 冬期"
                    if(month == 1|| month == 2)
                        year = year - 1
                    end
                    @ranks = @ranks.where("strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}01' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}02' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}12'")
                end
                @datetitle = "#{year}年#{season}"
            else
                #数値以外が入れられているとき
                redirect_to "/"
                return
            end
        #日付が選択されていないURLが入れられているとき
        else
            @datetitle = " 歴代"
        end
        @color = getDungeonColor(@dungeonurl)
        @ranks = @ranks.order(:result).page(params[:page]).per(PER)
        render 'ranking'
    end

    #申請を押したときに新しいデータを作成
    def newrecord
        @rank = Rank.new
        #ログインしている場合は初期値を入れる
        if user_signed_in?
            @rank.name = current_user.name
            @rank.user_id = current_user.id
        end
    end

    #確認画面へ行くときのデータ運びとバリデーション
    def recordconfirm
        @rank = Rank.new(rank_params)
        @rank[:result]= params["hour"].to_i * 3600 + params["minute"].to_i * 60 + params["second"].to_i
        render :newrecord if @rank.invalid?
    end

    #申請後確認画面でOKを押したとき
    def create
        @rank = Rank.new(rank_params)
        if user_signed_in?
            @rank.user_id = current_user.id
        end
        if params[:cache][:image] != ""
            @rank.recordimage.retrieve_from_cache! params[:cache][:image]
        end
        if params[:back]
            render 'newrecord'
        elsif @rank.save! then
            SendDiscordWebHook(@rank)
            redirect_to "/"
        else
            render 'newrecord'
        end
    end

    private

    ############################################################Strong Parameter############################################################
    def rank_params
        params.require(:rank).permit(:name,:dungeon,:result,:movie,:resultdate,:recordimage)
    end
end
