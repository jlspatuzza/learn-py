class CoursesController < ApplicationController

  before_action :authenticate_user!
  after_action :verify_authorized, except: :index

  def index
    @courses = policy_scope(Course)
  end

  def show
    @course = Course.find(params[:id])
    authorize @course
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

  def edit
    @course = Course.find(params[:id])
    authorize @course
  end

  def update
    @course = Course.find(params[:id])
    authorize @course

    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    authorize @course
    @course.destroy
    redirect_to courses_path, notice: 'Course was successfully destroyed.'
  end


  private

  def course_params
    params.require(:course).permit(:name,:description,:date,:start_time,:end_time,:quantity,:price,:num_seats)

  end





end
