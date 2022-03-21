# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def user
     user = User.new(name: "木下 将太")

     User.send_mail(user)
  end

end
