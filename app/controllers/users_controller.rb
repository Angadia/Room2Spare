class UsersController < ApplicationController

  def new
      @user = User.new
  end

  def create
    byebug
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
          redirect_to root_path  
      else
          render :new
  end
end

private  #pensando em grab o valor do botao e isso preencher o is_manager, is_teacher, is_student
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


