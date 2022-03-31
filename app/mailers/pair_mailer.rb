class PairMailer < ApplicationMailer

  def welcome
    if Rails.env.development?
      @url = ENV["DEV_ROOT"] + "sign_up"
    elsif Rails.env.production?
      @url = ENV["PROD_ROOT"] + "sign_up"
    end
    @name = params[:name]
    @pair_id = params[:pair_id]
    email = params[:email]
    mail(
      to:   email,
      subject: 'nakanaoriご招待メール'
    )
  end

end
