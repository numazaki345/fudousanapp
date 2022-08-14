class SessionsController < ApplicationController
  skip_before_action :login_required
  skip_before_action :verify_authenticity_token

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'ログインしました。'
    else
      render :new
    end
  end

  # def create
  #   if (user = User.find_or_create_from_auth_hash(auth_hash))
  #     redirect_to root_url, notice: 'ログインしました。'
  #   else
  #     render :new
  #   end
  # end

  def destroy
    reset_session
    redirect_to root_url, notice: 'ログアウトしました。'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  # def auth_hash
  #   request.env['omniauth.auth']
  # end
end
