class ResetPassword < ActionMailer::Base
  default :from => "resetpassword@spknd.ru"
  
  def reset_password_email(user)
    @user = user
    @url  = "http://tihinfo.ru/login"
    unless Rails.env.development?
      recipient = @user.email
    else
      recipient = "SeredinAK@mail.sever.kes.ru"
    end
    mail(:to => recipient,
         :subject => t('mailer.subject_reset_password'))
  end
    
end
