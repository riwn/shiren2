class RankingController < ApplicationController

    def ranking
        @ranks = Rank.all
    end

    def requestrecord
        if request.post? then
            @dungeon
            if  params["rb1"] == "saihate" then
                @dungeon = "最果てへの道99FTA"
            elsif params["rb1"] == "ido" then
                @dungeon = "カラクロTA"
            elsif params["rb1"] == "jinja" then
                @dungeon = "女王グモ捕獲TA"
            elsif params["rb1"] == "onigashima" then
                @dungeon = "鬼ヶ島ありありTA"
            else
                @dungeon = "ストーリーTA"
            end
            @result = params["hours"].to_i * 3600 + params["minutes"].to_i* 60 + params["seconds"].to_i
                        Rank.create(
                name: params["recorder"],
                dungeon: @dungeon,
                result: @result,
                movie: params["url"],
                resultdate: params["recorddate"]
                )
            redirect_to "/ranking"
        end

    end
end
