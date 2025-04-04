class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save

      # Eğer kullanıcı berberse, barbers tablosuna da ekle
      if resource.role == 'barber'
        Barber.create(user_id: resource.id, name: resource.email.split('@').first)
      end

      if resource.role == 'customer'
        Customer.create(user_id: resource.id, name: '', phone: '')
      end

      render json: {
        status: { code: 200, message: 'Kayıt başarılı.' },
        data: resource
      }, status: :ok
    else
      render json: {
        status: { code: 422, message: 'Kayıt başarısız.', errors: resource.errors.full_messages }
      }, status: :unprocessable_entity
    end
  end
  
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

end