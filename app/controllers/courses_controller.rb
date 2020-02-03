class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_course, only: [:edit,:update,:show, :destroy, :drop, :enroll]
  before_action :authorize!, only: [:edit, :update, :destroy]

  def enroll
    enrollment = current_user.enrollments.where(course_id: @course.id)
    if enrollment.empty?
      current_user.enrollments.create(course_id: @course.id, status: "Enrolled")
    else
      puts "Course enrollment updated"
      enrollment.update ({status: "Enrolled"})
    end
    flash[:notice] = 'Course Enrolled Successfully'
    redirect_to @course
  end

  def drop
    enrollment = current_user.enrollments.where(course_id: @course.id)
    enrollment.update ({status: "Pending"})
    flash[:notice] = 'Course Dropped Successfully'
    redirect_to @course
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    @course.user = current_user
    if @course.save
      flash[:notice] = 'Course Created Successfully'
      redirect_to @course
    else
      render :new
    end
  end
  
  def edit
    
  end
  
  def update    
    if @course.update course_params
      flash[:notice] = 'Course Updated Successfully'
      redirect_to @course
    else
      render :edit
    end
  end

  def index
    if current_user.is_admin
      @courses = Course.order(created_at: :desc)
    elsif current_user.is_teacher
      @courses = Course.where(user_id: current_user.id).order(created_at: :desc)
    elsif current_user.is_student
      @courses = current_user.enrolled_courses
      @open_courses = Course.where(status: "Open").order(created_at: :desc)
    end
  end

  def show

  end

  def destroy
    @course.destroy
    flash[:notice] = 'Course Updated Successfully'
    redirect_to courses_path
  end
  
  private

  def find_course
    @course = Course.find params[:id]
  end

  def course_params
    params.require(:course).permit(:title, :description, :status, :tuition, :capacity, :image_url)
  end

  def authorize! 
    unless can?(:crud, @course)
      redirect_to root_path, alert: 'Not Authorized' 
    end
  end
end
