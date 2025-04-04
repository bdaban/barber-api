# app/controllers/admin/base_controller.rb
class Admin::BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
  
    private
  
    def authorize_admin!
      render json: { error: "Yetkisiz erişim" }, status: :unauthorized unless current_user&.admin?
    end
  end
  