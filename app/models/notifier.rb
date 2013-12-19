class Notifier < ActionMailer::Base
  default_url_options[:host] = "bootlegdatabase.com"

  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          "support@bootlegdatabase.com"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
  
  def contact(email_params)
    subject "[bootlegdatabase.com] " << email_params[:subject]
    recipients "superklye@gmail.com"
    from email_params[:email]
    sent_on Time.now.utc
    
    body :message => email_params[:body], :name => email_params[:name], :subject => email_params[:subject], :email => email_params[:email]
  end
end
