class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :barber

  # TEMP: enum'u kaldırıyoruz
  # enum status: {
  #   pending: 0,
  #   approved: 1,
  #   rejected: 2,
  #   cancelled: 3
  # }

  # Bunun yerine direkt default değer atarız
  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= 0  # veya varsayılan durum 'pending' ise 0
  end
end
