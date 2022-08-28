class ClientMailer < ApplicationMailer
  default from: 'fudousan@example.com'

  def creation_email
    @client = params[:client]
    mail(
      subject: 'お客様情報登録',
      to: @client.email,
    )
  end

  def building_email
    @email = params[:email]
    mail(
      subject: 'ご紹介物件',
      to: @email.email,
    )
  end
end
