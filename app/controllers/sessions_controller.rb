class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by_email params[:email]
        if user&.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect_to root_path, notice: "You are logged In"
        else
            flash[:alert] = "Sorry, you must have inserted a wrong email or password"
            render :new
        end
    end



end
