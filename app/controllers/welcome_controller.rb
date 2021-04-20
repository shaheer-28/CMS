class WelcomeController < ApplicationController
  before_action :check_user_logged_in
  skip_before_action :authenticate_user!, only: [:index]

  def index
  end

  private

  def check_user_logged_in
    if user_signed_in?
      redirect_to admin_camps_path if current_user.admin?
      redirect_to users_path if current_user.user?
    end
  end
end
