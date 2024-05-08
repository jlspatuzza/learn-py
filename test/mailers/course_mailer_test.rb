require "test_helper"

class CourseMailerTest < ActionMailer::TestCase
  test "creation" do
    mail = CourseMailer.creation
    assert_equal "Creation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
