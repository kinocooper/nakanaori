class ApplicationController < ActionController::Base

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

end
