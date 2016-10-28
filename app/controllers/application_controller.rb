class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, only: Proc.new { |c| !c.request.format.json? }

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  ITEMS_PER_PAGE = 10
  
  def authenticate!
    unless Rails.env.test?
      auth = authenticate_from_token!
      if auth.is_a?(String)
        render json: { success: false, errors: { message: [auth] } }, status: 401 and return
      end
      unless signed_in?
        redirect_to root_path, alert: "Please sign in to continue" and return
      end
    end
  end

  def authenticate_from_token!
    request.env['warden'].request.env['devise.skip_trackable'] = '1'
    if params[:auth_token].present?

      if user = User.find_by_authentication_token(params[:auth_token])
        sign_out if signed_in?
        sign_in user , store: false
        #        logger.debug "Current user is now #{current_user.inspect}"
      else
        return "Error with your user token"
      end
    end
  end

  def authenticate_support_agent!
    authenticate!
    unless current_user.role == User::ROLE[:support_agent]
      throw(:warden)
    end
  end

  def authenticate_admin!
    authenticate!
    unless Rails.env.test?
      unless current_user.role == User::ROLE[:admin]
        throw(:warden)
      end
    end
  end
  
  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PATCH, PUT, DELETE'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Max-Age'] = "1728000"
  end
  
  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.
  def cors_preflight_check
    logger.debug "in cors_preflight_check{ request: #{request.original_fullpath}, method :#{request.method} }"
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PATCH, PUT, DELETE'
      headers['Access-Control-Allow-Headers'] = '*'
      headers['Access-Control-Max-Age'] = '1728000'
      head :no_content
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    sign_out
    respond_to do |format|
      format.html { redirect_to(sign_ins_path) }
      format.xml  { render xml:  { error: 'Forbidden' }, status: :forbidden }
      format.json { render json: { error: 'Forbidden' }, status: :forbidden }
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_to do |format|
      format.html { render :file => File.join(Rails.root, 'public', '404.html') }
      format.json { render :json => {:error => "404 Not found"}.to_json, :status => 404 }
    end
  end
end
