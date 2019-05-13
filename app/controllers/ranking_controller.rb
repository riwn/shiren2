class RankingController < ApplicationController

    ######################################################メソッド########################################################

    #データベースからダンジョンに応じたデータを取得
    def rankchoose(dungname)
        if dungname == "歴代TA"
            return Rank.where(permission: 1)
        end
        return Rank.where(dungeon: dungname)
    end

    #アーカイブのデータを取得する
    def getArchive(rankdata)
        if rankdata!= nil
            return rankdata.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
        end
        return nil
    end

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
        elsif dungeonURLStr == "all"
            return "歴代TA"
        else
            return ""
        end
    end

    ######################################################メソッド終わり######################################################

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
        @ranks = rankchoose(@dungeonname)
        @ranks = @ranks.where(permission: true)
        #アーカイブを取得(各日付と記録数を取得)
        @archives =getArchive(@ranks)
        if params[:yyyymm] != nil
            if(params[:yyyymm]=~ /^[0-9]+$/)
                @yyyymm = params[:yyyymm]
                year = @yyyymm[0,4].to_i
                month = @yyyymm[4,2].to_i
                season = ""
                if(month == 3 || month == 4|| month == 5)
                    season = "春期"
                    @ranks = @ranks.where("strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}03' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}04' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}05'")
                elsif(month == 6 || month == 7 || month == 8)
                    season = "夏期"
                    @ranks = @ranks.where("strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}06' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}07' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}08'")
                elsif(month == 9 || month == 10|| month == 11)
                    season = "秋期"
                    @ranks = @ranks.where("strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}09' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}10' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}11'")
                elsif(month == 12 || month == 1|| month == 2)
                    season = "冬期"
                    if(month == 1|| month == 2)
                        year = year - 1
                    end
                    @ranks = @ranks.where("strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}01' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}02' or strftime('%Y%m', created_at) = '#{@yyyymm[0,4]}12'")
                end
                @datetitle = "#{year}年#{season}ランキング"
            else
                #数値以外が入れられているとき
                redirect_to "/"
                return
            end
        #日付が選択されていないURLが入れられているとき
        else
            @datetitle = " 歴代ランキング"
        end
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
        render :newrecord if @rank.invalid? || !(@rank[:resultdate].to_date <= Date.today)
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
