class HomeController < ApplicationController
    def top
        #選択されたダンジョンの記録のみを抽出
        @ranks = Rank.all
        nowDate = Time.now
        @ranks = @ranks.where(created_at: (nowDate.ago(nowDate.month.modulo(3)).beginning_of_month)..(nowDate.since(2 - nowDate.month.modulo(3)).end_of_month))

        @dungeons = Constants::DUNGEON_NAME
        @links = Constants::DUNGEON_LINK
        @colors = Constants::DUNGEON_COLOR
        @ranks = @ranks.order(:result)
        @topranks = []
        @dungeons.each do |dungeon|
            @topranks.push(@ranks.RankDungeonChoose(dungeon).limit(3))
        end
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

    private

    def opinion_params
        params.require(:opinion).permit(:content)
    end
end
