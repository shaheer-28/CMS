class WelcomeController < ApplicationController
  before_action :check_user_logged_in
  skip_before_action :authenticate_user!, only: [:index]

  def index
  end

  private

  def check_user_logged_in
    redirect_to new_user_session_path if user_signed_in?
  end
end
