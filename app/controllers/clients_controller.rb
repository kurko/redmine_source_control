class ClientsController < ApplicationController
  unloadable

  def index
    @client = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      flash[:notice] = "Cliente adicionado com sucesso"
      redirect_to :controller => 'source_control', :action => 'index'
    else
      flash[:failure] = "Ocorreu um erro ao cadastrar cliente"
      render :action => 'new'
    end
  end

  def update
  end

  def edit
  end

  def delete
  end
end
