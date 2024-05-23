class User < ApplicationRecord
  has_many :courses
  before_validation :set_defaults
  after_create :send_welcome_email
  after_create :subscribe_to_newsletter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


  private

  def set_defaults
    status = "visitor" if status.blank?
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

  def subscribe_to_newsletter
    Rails.logger.info("Subscribing #{email} to Mailchimp.")
    SubscribeToNewsletterService.new(self).subscribe
  end

end
