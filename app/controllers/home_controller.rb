class HomeController < ApplicationController
    def top
        d = Date.today
        @nowyyyymm = d.year.to_s + ("%02d" % d.month).to_s
        month = d.month
        #選択されたダンジョンの記録のみを抽出
        @ranks = Rank.all
        if(month == 3 || month == 4|| month == 5)
            @ranks = @ranks.where("strftime('%Y%m', created_at) = '#{@nowyyyymm[0,4]}03' or strftime('%Y%m', created_at) = '#{@nowyyyymm[0,4]}04' or strftime('%Y%m', created_at) = '#{@nowyyyymm[0,4]}05'")
        elsif(month == 6 || month == 7 || month == 8)
            @ranks = @ranks.where("strftime('%Y%m', created_at) = '#{@nowyyyymm[0,4]}06' or strftime('%Y%m', created_at) = '#{@nowyyyymm[0,4]}07' or strftime('%Y%m', created_at) = '#{@nowyyyymm[0,4]}08'")
        elsif(month == 9 || month == 10|| month == 11)
            @ranks = @ranks.where("strftime('%Y%m', created_at) = '#{@nowyyyymm[0,4]}09' or strftime('%Y%m', created_at) = '#{@nowyyyymm[0,4]}10' or strftime('%Y%m', created_at) = '#{@nowyyyymm[0,4]}11'")
        elsif(month == 12 || month == 1|| month == 2)
            if(month == 1|| month == 2)
                year = year - 1
            end
            @ranks = @ranks.where("strftime('%Y%m', created_at) = '#{@nowyyyymm[0,4]}01' or strftime('%Y%m', created_at) = '#{@nowyyyymm[0,4]}02' or strftime('%Y%m', created_at) = '#{@nowyyyymm[0,4]}12'")
        end
        @dungeons = ["最果てへの道99FTA","カラクロTA","鬼ヶ島ありありTA","ストーリーTA","女王グモ捕獲TA"]
        @links = ["saihate","well","onigashima","story","shrine"]
        @colors = ["bg-primary","bg-warning","bg-danger","bg-success","bg-dark"]
        @ranks = @ranks.order(:result)
        @topranks = []
        @dungeons.each do |dungeon|
            @topranks.push(@ranks.RankDungeonChoose(dungeon).limit(3))
        end
        #@saihateRank = @ranks.RankDungeonChoose("最果てへの道99FTA").limit(3)
        #@wellRank = @ranks.RankDungeonChoose("カラクロTA").limit(3)
        #@onigashimaRank = @ranks.RankDungeonChoose("鬼ヶ島ありありTA").limit(3)
        #@storyRank = @ranks.RankDungeonChoose("ストーリーTA").limit(3)
        #@shrineRank = @ranks.RankDungeonChoose("女王グモ捕獲TA").limit(3)
    end

    def ta

    end
end
