class BarbersController < ApplicationController
  def index
    barbers = Barber.all
    render json: barbers
  end
 
 
  def available_times
    date = params[:date]
    barber = Barber.find(params[:id])
  
    puts "🧪 İstenen Tarih: #{date}"
    puts "🧪 Barber ID: #{barber.id}"
  
    english_day = Date.parse(date).strftime("%A")
    turkish_day = {
      "Monday" => "Pazartesi",
      "Tuesday" => "Salı",
      "Wednesday" => "Çarşamba",
      "Thursday" => "Perşembe",
      "Friday" => "Cuma",
      "Saturday" => "Cumartesi",
      "Sunday" => "Pazar"
    }[english_day]
  
    puts "🧪 Türkçe gün: #{turkish_day}"
  
    working_hours = barber.working_hours.where(day: turkish_day)
    puts "🧪 WorkingHours bulundu mu? #{working_hours.present?}"
  
    if working_hours.empty?
      render json: [] and return
    end
  
    all_slots = working_hours.flat_map do |wh|
      puts "🔍 Saat Aralığı: #{wh.start_time} - #{wh.end_time}"
      (Time.parse(wh.start_time).hour...Time.parse(wh.end_time).hour).map { |h| "#{h.to_s.rjust(2, '0')}:00" }
    end.uniq
  
    puts "🕓 Tüm slotlar: #{all_slots.inspect}"
  
    taken = barber.appointments.where(date: date).pluck(:time)
    puts "📦 Alınmış saatler: #{taken.inspect}"
  
    available = all_slots - taken
    puts "✅ Uygun saatler: #{available.inspect}"
  
    render json: available
  end
  
  

  
  
  
end


