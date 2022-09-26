class ApplicationController < ActionController::Base

  before_action :set_locale
  before_action :authenticate_user!, :except => [:about, :index]
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  protected

  def configure_permitted_parameters    
    devise_parameter_sanitizer.permit :sign_up, keys: [:username, :email]    
    devise_parameter_sanitizer.permit :account_update, keys: [:content, :username, :email]
  end

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path(locale: I18n.locale)
  end

  def after_sign_in_path_for(resource_or_scope)
    root_path(locale: I18n.locale)
  end

  def default_url_options
    { locale: ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
  end

  def set_locale
    I18n.locale = I18n.available_locales.include?(params[:locale].to_sym) && params[:locale] || I18n.default_locale
  end
  
end
