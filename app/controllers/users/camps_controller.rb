class Users::CampsController < Users::UsersController
  def index
    @camps = Camp.all
  end
end
