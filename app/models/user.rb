class User < ApplicationRecord
  has_many :courses
  # after_create :send_welcome_email
  before_validation :set_defaults
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  private

  def set_defaults
    status = "visitor" if status.blank?
  end

  # def send_welcome_email
  #   UserMailer.welcome(self).deliver_now
  # end

end
