class EmailsController < ApplicationController
  def new
    @email = Email.new
  end

  def create
    @email = Email.new(email_params)

    if @email.save
      ClientMailer.with(email: @email).building_email.deliver_now
      redirect_to clients_path, notice: "メールをを送信しました。"
    else
      render :new
    end
  end

  private
  def email_params
    params.require(:email).permit(:email, :building_url)
  end
end
