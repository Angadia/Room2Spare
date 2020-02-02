class UsersController < ApplicationController

  def new
      @user = User.new
  end

  def create
      @user = User.new user_params
      if params[:user_type] == "manager"
        @user.is_manager = true
      elsif params[:user_type] == "teacher"
        @user.is_teacher = true
      elsif params[:user_type] == "student"
        @user.is_student = true
      end
      if @user.save
          session[:user_id] = @user.id
          if @user.is_admin == true || @user.is_manager == true
           redirect_to facilities_path   #this is not the final redicrection, just test, change home link in application erb
          elsif @user.is_teacher
            redirect_to courses_path
          else
            redirect_to courses_path    #this is not the final redicrection, just test
          end
      else
          render :new
  end
end



private  
def user_params
  params.require(:user).permit(
    :first_name,
    :last_name,
    :email,
    :contact_number,
    :is_manager,
    :is_teacher,
    :is_student,
    :password,
    :password_confirmation
  )
end


end


