class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:username], params[:password])
        if @user
            @user.reset_session_token!
            redirect_to cats_url
        else
            redirect_to user_url(new_user)
        end
    end

    def destroy
    end
end
