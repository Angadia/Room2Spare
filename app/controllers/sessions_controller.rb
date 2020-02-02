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

    def destroy
        session[:user_id] = nil
        redirect_to new_session_path, notice: "Logged out!" #this is not the final redirection, waiting for root_path definition
    end



end
