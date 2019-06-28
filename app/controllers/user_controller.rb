class UserController < ApplicationController

    PER = 10

    def profile
        @uid = params[:id]
        @user = User.find_by_id(@uid)
        if @user.nil?
            redirect_to "/"
            return
        end
        @title = @user.name + "のプロフィール"
        @ranks = @user.ranks
        @dungeons = Constants::DUNGEON_NAME
        @links = Constants::DUNGEON_LINK
        @colors = Constants::DUNGEON_COLOR
        @ranks = @ranks.order(:result)
        @myranks = []
        @dungeons.each do |dungeon|
            @myranks.push(@ranks.RankDungeonChoose(dungeon).page(params[:page]).per(PER))
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
        @user.cavetube = params[:cavetube]
        @user.save
        redirect_to "/user/#{params[:id]}"
    end
end
