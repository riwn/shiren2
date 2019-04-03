class RankingController < ApplicationController

    def ranking
        @ranks = Rank.all
    end

    def create
        @rank = Rank.new(rank_params)
        
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
