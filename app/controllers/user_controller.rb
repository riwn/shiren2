class UserController < ApplicationController
    def profile
        @uid = params[:id]
        @user = User.find_by_id(@uid)
        if @user.nil?
            redirect_to "/"
            return
        end
        @title = @user.name + "のプロフィール"
        #if user_signed_in?
            #数値以外が入れられているとき
          #  redirect_to "/"
         #   return
        #end
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
