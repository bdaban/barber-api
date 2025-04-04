class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'Giriş başarılı.' },
      data: resource
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "Çıkış başarılı."
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Kullanıcı bulunamadı veya zaten çıkış yapmış."
      }, status: :unauthorized
    end
  end
end

