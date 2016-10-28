class Api::SessionsController < Api::BaseController
  before_action :authenticate!, :only => [:destroy ]
  before_filter :ensure_params_exist

  def create
    resource = User.find_for_database_authentication(:email=>params[:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:password])
      sign_in("user", resource)
      render json: {success: true, user: {id: resource.id, auth_token: resource.authentication_token, role: resource.role, email: resource.email}}
      return
    end
    invalid_login_attempt
  end

  def destroy
    sign_out(resource_name)
  end

  protected
  def ensure_params_exist
    return unless params[:email].blank? or params[:password].blank?
    render json: {success: false, message: "missing user_login parameter"}, status: 422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render json: {success: alse, message: "Error with your login or password"}, status: 401
  end
end