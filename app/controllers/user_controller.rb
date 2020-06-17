class UserController < ApplicationController

    PER = 10

    def profile
        @uid = params[:id]
        @user = User.find_by_id(@uid)
        if @user.nil?
            redirect_to "/"
            return
        end
        @dungeons = Dungeon.all
        # 許可済みの記録
        @allranks = @user.ranks
        @ranks = @allranks.where(permission: true)
        @ranks = @ranks.order(:result)
        @myranks = []
        @dungeons.each do |dungeon|
            @myranks.push(@ranks.RankDungeonChoose(dungeon.id).page(params[:page]).per(PER))
        end

        # 許可前の記録
        @nopermitranks = @allranks.where(permission: false).where(rejection: false)

        # 拒否された記録
        @rejectioncount = 0
        @rejectranks = @user.ranks.where(rejection: true)
        @rejectranks.each do |rank|
            puts Time.now - rank.created_at
            if Time.now - rank.created_at < 604800
                @rejectioncount = @rejectioncount + 1
            end
        end


        # これ以下はAjax通信の場合のみ通過
        return unless request.xhr?

        case params[:type]
        when 'saihate', 'well','onigashima','story','shrine'
            render "user/#{params[:type]}"
        end
    end

    def edit
        @uid = params[:id]
        if current_user.id != @uid.to_i
            redirect_to "/"
            return
        end
        @user = User.find_by_id(@uid)
    end

    def update
        @user = User.find_by_id(params[:id])
        @user.niconico = params[:niconico]
        @user.youtube = params[:youtube]
        @user.twitch = params[:twitch]
        @user.introduction = params[:text]
        if params[:icon] != nil
            @user.icon = params[:icon]
        end
        if @user.save
            redirect_to "/user/#{params[:id]}"
        else
            render :edit
        end
    end
end
