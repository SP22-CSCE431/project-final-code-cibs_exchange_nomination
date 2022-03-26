class ApplicationController < ActionController::Base
    before_action :authenticate_admin!, except: [:user_new, :user_show, :user_create, :finish, :user_edit, :user_update]

    #before_action :authorize_user!, only: [:user_edit, :user_update]

    #def authorize_user!
    #  redirect_to root_path unless session[:id].present?
    #end
end
