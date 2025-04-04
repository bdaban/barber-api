class Me::BarbersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_barber

  def show
    render json: @barber
  end

  def update
    if @barber.update(barber_params)
      render json: { message: 'Profil güncellendi', data: @barber }, status: :ok
    else
      render json: { message: 'Güncelleme başarısız', errors: @barber.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_barber
    if current_user&.barber
      @barber = current_user.barber
    else
      render json: { message: 'Berber bulunamadı' }, status: :not_found
    end
  end

  def barber_params
    params.require(:barber).permit(:name, :address, :phone)
  end
end
