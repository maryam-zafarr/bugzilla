# frozen_string_literal: true

# Application Controller lass
class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include ApplicationHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :null_session

  protected

  def record_not_found
    redirect_to dashboard_path, alert: 'Does not exist.'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name user_type])
  end
end
