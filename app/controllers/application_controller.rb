class ApplicationController < ActionController::Base

    private
    
    def user_signed_in?
        current_user.present?
    end

    helper_method :user_signed_in?

    def current_user
        if session[:user_id].present?
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end
    helper_method :current_user
    

    def authenticate_user!
        unless user_signed_in?
            flash[:alert] = "Please sing in first."
            redirect_to new_session_path
        end
    end

    def user_type(user)
        if user.is_teacher == true
             "Teacher"
        elsif user.is_manager == true
             "Manager"
        elsif user.is_student == true
             "Student"
        end
    end
    helper_method :user_type

end
