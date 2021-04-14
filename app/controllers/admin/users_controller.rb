class Admin::UsersController < ApplicationController
	#before_action :authenticate_user!

	def index
		@users = User.where(role: User.roles[:user])
	end
end
