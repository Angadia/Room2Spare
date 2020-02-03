class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by_email params[:email]
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:notice] = 'You are logged in'
            if user.is_admin  || user.is_manager
                redirect_to facilities_path   #this is not the final redicrection, just test
               elsif user.is_teacher
                 redirect_to courses_path
               else
                 redirect_to courses_path   #waiting for enrollments path to make sure it works
                #  redirect_to enrollments_path
            end
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
