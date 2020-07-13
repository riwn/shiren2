class HomeController < ApplicationController
    def top
        #選択されたダンジョンの記録のみを抽出
        @ranks = Rank.all
        nowDate = Time.now
        year = nowDate.year
        month = nowDate.month
        season, @ranks = @ranks.GetSeasonRecord(year,month)
        @ranks = @ranks.order(:result)
        @dungeons = Dungeon.all
        @topranks = []
        @dungeons.each do |dungeon|
            @topranks.push(@ranks.RankDungeonChoose(dungeon.id).RankBestOnly.limit(3))
        end
        #バナー用
        @banners = Banner.all
    end

    def opinion
        @opinion = Opinion.new
    end

    def sendopinion
        @opinion = Opinion.new(opinion_params)
        if @opinion.save
            redirect_to "/"
        else
            render :opinion
        end
    end

    def description

    end

    private

    def opinion_params
        params.require(:opinion).permit(:content)
    end
end
