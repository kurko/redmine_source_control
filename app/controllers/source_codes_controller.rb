class SourceCodesController < ApplicationController
  unloadable


  def index
    @source = SourceCode.all(:conditions => [ 'client_id = ?', params[:client_id] ] )
  end

  def show
  end

  def new
    @client = Client.find_by_id(params[:client_id])
    @source = @client.source_codes.build
  end

  def edit
  end

  def create
  end

  def update
  end

  def delete
  end
end
