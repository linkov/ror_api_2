class UsersMailer < ActionMailer::Base

  def welcome_email(user_id)
    @user = User.find(user_id)

    mail(   :to      => @user.email,
            :subject => "Welcome",
            :sender => 'info@8feedback.com'
    ) do |format|
      format.text
      format.html
    end
  end

  def new_message_email(from_user_id,to_user_id,message_text)
    @text = message_text
    @user = User.find(to_user_id)
    @sender = User.find(from_user_id)

    mail(   :to      => @user.email,
            :subject => "New message from "+@sender.email,
            :sender => 'info@8feedback.com'
    ) do |format|
      format.text
      format.html
    end
  end

end
