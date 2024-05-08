class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
    authorize @course
  end

  def create

    @course = current_user.courses.build(course_params)
    authorize @course

    if @course.save
      mail = CourseMailer.with(course: @course).creation
      mail.deliver_now
      redirect_to courses_path
    else
      render :new

    end

  end

  private

  def course_params
    params.require(:course).permit(:name,:description,:date,:start_time,:end_time,:quantity,:price,:num_seats)

  end





end
