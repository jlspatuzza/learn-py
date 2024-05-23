

# app/services/mailchimp_service.rb
class SubscribeToNewsletterService
  def initialize(user)
    @user = user
    @list_id = ENV["MAILCHIMP_AUDIENCE_ID"]
  end

  def subscribe
    gibbon = Gibbon::Request.new
    begin
      # Check if the email already exists in the list
      member_id = Digest::MD5.hexdigest(@user.email.downcase)
      response = gibbon.lists(@list_id).members(member_id).retrieve

      # If the email exists, update the subscriber
      update_subscriber(member_id)
    rescue Gibbon::MailChimpError => e
      if e.title == "Member Exists"
        Rails.logger.info("Mailchimp: Member already exists, updating subscriber.")
        update_subscriber(member_id)
      elsif e.status == 404
        # If not found, create a new subscriber
        create_subscriber
      else
        Rails.logger.error("Mailchimp error: #{e.message}")
      end
    end
  end

  private

  def create_subscriber
    gibbon = Gibbon::Request.new
    gibbon.lists(@list_id).members.create(
      body: {
        email_address: @user.email,
        status: "subscribed",
        merge_fields: {
          FNAME: @user.first_name,
          LNAME: @user.last_name
        }
      }
    )
  end

  def update_subscriber(member_id)
    gibbon = Gibbon::Request.new
    gibbon.lists(@list_id).members(member_id).update(
      body: {
        email_address: @user.email,
        status: "subscribed",
        merge_fields: {
          FNAME: @user.first_name,
          LNAME: @user.last_name
        }
      }
    )
  rescue Gibbon::MailChimpError => e
    Rails.logger.error("Mailchimp update error: #{e.message}")
  end
end
