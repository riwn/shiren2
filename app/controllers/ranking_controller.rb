class RankingController < ApplicationController

    def ranking
        @ranks = Rank.all
    end

end
