class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    if verify_recaptcha
      super
    else
      flash.now[:error] = 'Incorrect recaptcha! Please try again.'
      render :new
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :login, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :login, :password, :password_confirmation, :current_password)
  end

end

