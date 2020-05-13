class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include LabelsHelper
  def authenticate_user
    redirect_to new_session_path if current_user.nil?
  end
end
