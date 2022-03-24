class ApplicationController < ActionController::Base

  # deviseのコントローラ群使用時、
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 未ログイン時はアバウト以外アクセス不可
  before_action :authenticate_user!, except:[:about]

  # ログインしたらトップに飛ぶ
  def after_sign_in_path_for(resource)
    root_path
  end

  # ログアウトしたらアバウトに飛ぶ
  def after_sign_out_path_for(resource)
    about_path
  end



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :partner_id, :pair_id])
  end


  def pair_nil_check
    if current_user.pair_id == nil
      redirect_to new_pair_path
    end
  end

end
