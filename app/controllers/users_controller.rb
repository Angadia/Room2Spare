class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update]
  before_action  :authenticate_user!, only: [:edit, :update]

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
      if @user.is_admin  || @user.is_manager 
       redirect_to facilities_path   #this is not the final redicrection, just test
      elsif @user.is_teacher
        redirect_to courses_path
      else
        redirect_to courses_path   #waiting for enrollments path to make sure it works
        #  redirect_to enrollments_path
      end
  else
      render :new
end
end



def edit
  if can? :crud, @user
    render :edit
  else
    redirect_to root_path flash[:alert] = "You dont have permission to update other user's info"
  end
end


def update
  if can? :crud, @user
    if @user.update user_params
        flash[:notice] = 'User updated Successfully'
        if @user.is_admin || @user.is_manager
          redirect_to facilities_path   #this is not the final redicrection, just test, change home link in application erb
         elsif @user.is_teacher
           redirect_to courses_path
         else
           redirect_to courses_path   #waiting for enrollments path to make sure it works
           #  redirect_to enrollments_path
         end
      else
        render :edit
    end
  else
      flash[:alert] = "You dont have permission to update other user's info"
      redirect_to root_path
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

def find_user
  @user=User.find params[:id]
end

end


