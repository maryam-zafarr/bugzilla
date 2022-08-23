# frozen_string_literal: true

# Application Controller lass
class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  include Pundit::Authorization
  include ApplicationHelper

  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def record_not_found
    # render file: "#{Rails.root}/app/views/application/error_404"
    redirect_to dashboard_path, alert: 'Does not exist.'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name user_type])
  end
end
