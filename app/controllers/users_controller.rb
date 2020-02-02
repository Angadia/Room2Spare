class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update]
  before_action  :authenticate_user!, only: [:update]

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
<<<<<<< HEAD
=======


>>>>>>> 21233d16f1b6e4bad165ea7b4a4d5c2d7ce431ea
      else
          render :new
  end
end


def edit
<<<<<<< HEAD
  if can? :crud, @user
    render :edit
  else
    redirect_to root_path flash[:alert] = "You dont have permission to update other user's info"
  end
=======
>>>>>>> 21233d16f1b6e4bad165ea7b4a4d5c2d7ce431ea
end


def update
  if can? :crud, @user
    if @user.update user_params
        flash[:notice] = 'User updated Successfully'
        if @user.is_admin == true || @user.is_manager == true
          redirect_to facilities_path   #this is not the final redicrection, just test, change home link in application erb
         elsif @user.is_teacher
           redirect_to courses_path
         else
           redirect_to courses_path    #this is not the final redicrection, just test
         end
      else
        render :edit
    end
  else
      flash[:alert] = "You dont have permission to update other user's info"
      redirect_to root_path
 end
end 

# user type is not updating properly. it keeps the true value from sign up and it acumulates roles



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

def find_user
  @user=User.find params[:id]
end

end


