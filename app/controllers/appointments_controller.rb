class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    existing = Appointment.find_by(
      barber_id: appointment_params[:barber_id],
      date: appointment_params[:date],
      time: appointment_params[:time]
    )

    if existing
      render json: { error: 'Bu saat için zaten randevu alınmış.' }, status: :unprocessable_entity
      return
    end

    appointment = current_user.appointments.new(appointment_params)

    if appointment.save
      render json: appointment, status: :created
    else
      render json: { errors: appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # def index
  #   appointments = current_user.appointments.includes(:barber)
  #   render json: appointments.as_json(include: { barber: { only: [:name] } })
  # end
  def index
    if current_user.role == 'barber'
      # Sadece login olan berbere ait randevular
      barber = current_user.barber
      if barber
        render json: barber.appointments.includes(:user)
      else
        render json: { error: 'Berber bulunamadı' }, status: :not_found
      end
    else
      # Müşteri ise kendi randevularını göster
      render json: current_user.appointments.includes(:barber)
    end
  end

  def destroy
    appointment = current_user.appointments.find_by(id: params[:id])
    if appointment
      appointment.destroy
      render json: { message: 'Randevu iptal edildi.' }
    else
      render json: { error: 'Randevu bulunamadı.' }, status: :not_found
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:barber_id, :date, :time)
  end

  def update
    appointment = Appointment.find(params[:id])
    if appointment.update(status: params[:status])
      render json: { message: "Randevu durumu güncellendi.", status: appointment.status }
    else
      render json: { errors: appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end



end
