class UsersController < ApplicationController

  def new
      @user = User.new
  end

  def create
      @user = User.new user_params
      if @user.save
          redirect to root_path
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
    :is_manager,
    :is_teacher,
    :is_student,
    :password,
    :password_confirmation
  )
end


end


