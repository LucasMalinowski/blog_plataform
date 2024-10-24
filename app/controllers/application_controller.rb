class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Skip CSRF protection for API requests
  skip_before_action :verify_authenticity_token, if: :api_request?

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Method to check if the request is an API request
  def api_request?
    request.format.json? || request.path.start_with?('/api/')
  end

  # Only skip the authentication requirement for API requests
  def require_no_authentication
    super unless api_request?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
