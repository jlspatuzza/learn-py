class User < ApplicationRecord
  has_many :courses
  before_validation :set_defaults
  after_create :send_welcome_email
  after_create :subscribe_to_newsletter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: %i[google_oauth2]



         def self.from_omniauth(access_token)
          data = access_token.info
          user = User.where(email: data['email']).first

          # Uncomment the section below if you want users to be created if they don't exist
          unless user
              user = User.create(
                email: data['email'],
                password: Devise.friendly_token[0, 20],
                confirmed_at: Time.now  # automatically confirm the user
              )
          end
          user
        end

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
