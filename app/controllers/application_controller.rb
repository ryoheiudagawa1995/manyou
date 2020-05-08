class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  def authenticate_user
    if current_user == nil
      redirect_to new_session_path
    end
  end
end
