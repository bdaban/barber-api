class WorkingHoursController < ApplicationController
    before_action :authenticate_user!
  
    def index
      hours = current_user.barber.working_hours
      render json: hours
    end
  
    def create
      hour = current_user.barber.working_hours.new(working_hour_params)
      if hour.save
        render json: hour, status: :created
      else
        render json: { errors: hour.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      hour = current_user.barber.working_hours.find(params[:id])
      if hour.update(working_hour_params)
        render json: hour
      else
        render json: { errors: hour.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      hour = current_user.barber.working_hours.find(params[:id])
      hour.destroy
      head :no_content
    end
  
    private
  
    def working_hour_params
      params.require(:working_hour).permit(:day, :start_time, :end_time)
    end
  end
  