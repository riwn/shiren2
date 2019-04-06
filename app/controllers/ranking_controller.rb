class RankingController < ApplicationController

    def ranking
        @ranks = Rank.where(permission: 1)
        if @ranks!= nil
            @archives = @ranks.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
        end
    end

    def onigashima
        @ranks = Rank.where(dungeon: "鬼ヶ島ありありTA")
        @ranksall = Rank.where(permission: 1)
        if @ranksall!= nil
            @archives = @ranksall.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
        end
        render 'ranking'
    end

    def well
        @ranks = Rank.where(dungeon: "カラクロTA")
        @ranksall = Rank.where(permission: 1)
        if @ranksall!= nil
            @archives = @ranksall.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
        end
        render 'ranking'
    end

    def shrine
        @ranks = Rank.where(dungeon: "女王グモ捕獲TA")
        @ranksall = Rank.where(permission: 1)
        if @ranksall!= nil
            @archives = @ranksall.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
        end
        render 'ranking'
    end

    def story
        @ranks = Rank.where(dungeon: "ストーリーTA")
        @ranksall = Rank.where(permission: 1)
        if @ranksall!= nil
            @archives = @ranksall.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
        end
        render 'ranking'
    end

    def saihate
        @ranks = Rank.where(dungeon: "最果てへの道99FTA")
        @ranksall = Rank.where(permission: 1)
        if @ranksall!= nil
            @archives = @ranksall.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
        end
        render 'ranking'
    end

    def archives
        @ranks= Rank.where(permission: 1)
        if @ranks!= nil
            @archives = @ranks.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
        end
        @yyyymm = params[:yyyymm]
        @ranks = @ranks.where("strftime('%Y%m', created_at) = '"+@yyyymm+"'")
        #@ranks = @ranks.make_archive
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
