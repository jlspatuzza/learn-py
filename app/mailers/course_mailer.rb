class CourseMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.course_mailer.creation.subject
  #
  def creation
    @course = params[:course]

    mail(
      to:       @course.user.email,
      subject:  "Course #{@course.name} created!"
    )
  end
end
