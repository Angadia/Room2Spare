class CoursesController < ApplicationController
  before_action :find_course, only: [:edit,:update,:show, :destroy]

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
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
    @courses = Course.order(created_at: :desc)
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
end
