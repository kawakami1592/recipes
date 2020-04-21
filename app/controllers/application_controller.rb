class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  # 登録時のストロングパラメータ追加

  def after_sign_in_path_for(resource)
    root_path # ログイン後に遷移する
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移する
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:lastname,:firstname,:lastname_kana,:firstname_kana])
  end
 
end