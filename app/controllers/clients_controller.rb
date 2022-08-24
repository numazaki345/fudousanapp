class ClientsController < ApplicationController
  skip_before_action :authenticate_user!, only:[:show]

  def index
    @clients = Client.all.includes(:condition).page(params[:page]).per(10).order("created_at desc")
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      ClientMailer.with(client: @client).creation_email.deliver_now
      redirect_to clients_path, notice: "#{@client.name}を登録しました。"
    else
      render :new
    end
  end

  def show
    @client = Client.find(params[:id])
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    client = Client.find(params[:id])
    client.update!(client_params)
    redirect_to clients_url, notice: "#{client.name}を更新しました。"
  end

  def destroy
    client = Client.find(params[:id])
    client.destroy
    redirect_to clients_url, notice: "#{client.name}を削除しました"
  end

  private
  def client_params
    params.require(:client).permit(:name, :email)
  end
end
