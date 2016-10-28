class Api::RegistrationsController < Api::BaseController

  def create
    user = User.new(params[:user])
    if user.save
      render json: user.as_json(id: user.id, auth_token: user.authentication_token, role: user.role, email: user.email), status: 201
      return
    else
      warden.custom_failure!
      render json: user.errors, status: 422
    end
  end

end