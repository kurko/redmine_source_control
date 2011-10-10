class SourceCodesController < ApplicationController
  unloadable


  def index
    @source = SourceCode.all(:conditions => [ 'client_id = ?', params[:client_id] ], :include => [:sourcecode_type] )
  end

  def show
  end

  def new
    @client = Client.find_by_id(params[:client_id])
    @source = @client.source_codes.build
    @sourcecode_type = @source.build_sourcecode_type
    @code_sector = @source.build_code_sector
    @code_sectors = CodeSector.find(:all).map { |e| [e.name, e.id]}
    @sourcecode_types = SourcecodeType.find(:all).map { |e| [e.name, e.id]}
  end

  def edit
    @client = Client.find(params[:client_id])
    @source = SourceCode.find(params[:id])
    @sourcecode_types = SourcecodeType.find(:all).map { |e| [e.name, e.id]}
    @code_sectors = CodeSector.find(:all).map { |e| [e.name, e.id]}
  end

  def create
    @source = SourceCode.new(params[:source_code])
    @source.client_id = params[:client_id]
    
    if @source.save
      flash[:notice] = "Registro criado com sucesso."
      redirect_to new_client_source_code_url
    else
      render :new
    end
  end

  def update
    
    @source = SourceCode.find(params[:id])
    @source.attributes = params[:source_code]
    
    if @source.save
      flash[:notice] = "Registro alterado com sucesso."
      redirect_to client_source_codes_url
    else
      render :edit
    end
    
  end

  def delete
  end
end
