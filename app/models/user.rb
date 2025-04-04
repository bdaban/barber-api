class User < ApplicationRecord
  has_one :barber, dependent: :destroy
  has_one :customer
  has_many :appointments

  devise :database_authenticatable,
         :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null



  after_initialize :set_default_role, if: :new_record?

  def barber?
    role == 'barber'
  end

  def admin?
    role == 'admin'
  end

  private

  def set_default_role
    self.role ||= 'customer'
  end
end
