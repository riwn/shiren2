class RankingController < ApplicationController

    def rankchoose(dungname)
        #ダンジョンに応じたデータ取得
        if dungname == "歴代TA"
            return Rank.where(permission: 1)
        end
        return Rank.where(dungeon: dungname)
    end

    def getArchive(rankdata)
        if rankdata!= nil
            return rankdata.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
        end
        return nil
    end

    def ranking
        @ranks = rankchoose("歴代TA")
        @archives =getArchive(@ranks)
        @rankingtitle = "歴代TAランキング"
    end

    def dungeon
        @dungeonname = ""
        if params[:dungeon] == "saihate"
            @dungeonname = "最果てへの道99FTA"
        elsif params[:dungeon] == "well"
            @dungeonname = "カラクロTA"
        elsif params[:dungeon] == "onigashima"
            @dungeonname = "鬼ヶ島ありありTA"
        elsif params[:dungeon] == "shrine"
            @dungeonname = "女王グモ捕獲TA"
        elsif params[:dungeon] == "story"
            @dungeonname = "ストーリーTA"
        elsif params[:dungeon] == "all"
            @dungeonname = "歴代TA"
        end

        @dungeonurl = params[:dungeon]
        @ranks = rankchoose(@dungeonname)
        @archives =getArchive(@ranks)
        if params[:yyyymm] != nil
            if(params[:yyyymm]=~ /^[0-9]+$/)
                @yyyymm = params[:yyyymm]
                @ranks = @ranks.where("strftime('%Y%m', created_at) = '"+@yyyymm+"'")
                @rankingtitle = "#{@yyyymm[0,4]}年#{@yyyymm[4,2]}月 #{@dungeonname}ランキング"
            end
        else
            @rankingtitle = @dungeonname + " 歴代ランキング"
        end
        render 'ranking'
    end

    def create
        @rank = Rank.new(rank_params)
        if params[:cache][:image] != ""
            @rank.recordimage.retrieve_from_cache! params[:cache][:image]
        end
        if params[:back]
            render 'newrecord'
        elsif @rank.save! then
            redirect_to "/ranking"
        else
            render 'newrecord'
        end
    end

    def newrecord
        @rank = Rank.new
    end

    def recordconfirm
        @rank = Rank.new(rank_params)
        @rank[:result]= params["hour"].to_i * 3600 + params["minute"].to_i * 60 + params["second"].to_i
        render :newrecord if @rank.invalid? || !(@rank[:resultdate].to_date <= Date.today)
    end

    private

    def rank_params
        params.require(:rank).permit(:name,:dungeon,:result,:movie,:resultdate,:recordimage)
    end
end
