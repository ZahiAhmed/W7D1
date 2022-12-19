class UsersController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by(user_params)
        if @user.save
            redirect_to user_url(@user)
        else
            render json: @user.errors.full_messages, status: 422
        end
    end

    def show
        @user = User.find_by(user_params)
        render json: @user
    end

end
