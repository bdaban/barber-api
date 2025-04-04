class Barbers::AppointmentsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      # Sadece kendi randevularını görebilen berber mantığı ileride eklenebilir
      appointments = Appointment.where(barber_id: params[:barber_id])
      render json: appointments.as_json(include: { user: { only: [:email] } })
    end
  end
  