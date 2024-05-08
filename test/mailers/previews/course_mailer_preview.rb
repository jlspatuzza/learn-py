# Preview all emails at http://localhost:3000/rails/mailers/course_mailer
class CourseMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/course_mailer/creation
  def creation
    CourseMailer.creation
  end

end
