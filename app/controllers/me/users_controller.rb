class Me::UsersController < ApplicationController
    before_action :authenticate_user!
  
    def update_password
      if current_user.update(password_params)
        render json: { message: 'Şifre başarıyla güncellendi' }, status: :ok
      else
        render json: { message: 'Şifre güncellenemedi', errors: current_user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
  