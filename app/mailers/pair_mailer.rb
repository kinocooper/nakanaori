class PairMailer < ApplicationMailer

  def welcome
    if Rails.env.development?
      @url = ENV["DEV_ROOT"]
    elsif Rails.env.production?
      @url = ENV["PROD_ROOT"]
    end
    @name = params[:name]
    email = params[:email]
    # @user = params[:user]
    # @url  = 'https://www.google.com/'
    # mail(to: @user.email, subject: 'googleへようこそ')
    mail(
      to:   email,
      subject: 'nakanaoriテストメール'
    )
  end

end
