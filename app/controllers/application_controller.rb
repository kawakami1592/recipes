class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  # 登録時のストロングパラメータ追加

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:lastname,:firstname,:lastname_kana,:firstname_kana,:zipcode,:Prefecture_id,:city,:address,:buildingname,:phone,:birthyear_id,:birthmonth_id,:birthday_id])
  end

end