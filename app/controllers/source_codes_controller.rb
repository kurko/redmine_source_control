class SourceCodesController < ApplicationController
  unloadable
  
  before_filter :set_default_conditions


  def index
    listing
  end
  
  def show
  end

  def new
    @client = Client.find_by_id(params[:client_id])
    @source = @client.source_codes.build
    @sourcecode_type = @source.build_sourcecode_type
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
      flash[:alert] = "Não foi possível atualizar o registro."
      render :edit
    end
    
  end

  def destroy
    @source = SourceCode.find(params[:id])
    if @source.destroy
      flash[:notice] = "Registro excluído com sucesso."
    else
      flash[:alert] = "Não foi possível excluir o registro."
    end
    redirect_to client_source_codes_url and return
  end
  
  # Called via Ajax
  def search
    
    params[:search][:field_name].each_with_index { |v, i|
      next if params[:search][:query][i.to_i].blank?
      query = params[:search][:query][i.to_i]
      field_query = search_special_fields v, query
      @conditions[0] << " AND "+field_query[:field]+" LIKE _utf8 '%"+field_query[:query]+"%' COLLATE utf8_unicode_ci"
    }
    
    listing
    render "search", :layout => false
  end
  
  private
  
    def search_special_fields field, query
      logger.debug "Field: " + field
      
      if field == "active"
        case query.downcase
        when "sim" then query = "1"
        when "não" then query = "0"
        when "nao" then query = "0"
        end
      end
      unless field =~ /\./
        field = "source_codes." + field
      end
      { :field => field, :query => query }
    end
    
    # Each query should have these conditions
    def set_default_conditions
      @conditions = [ 'source_codes.client_id = ?', params[:client_id] ]
    end
    
    # Creates all the results and pagination
    def listing

      @per_page = 200
      @page = params[:page].to_i || 1
      @page = 1 if @page <= 0
      @offset = (@page.to_i-1)*@per_page
      @offset = 0 if @offset < 0
      @total_offset = @offset + @per_page
    
      # default query
      query = { 
        :conditions => @conditions, 
        :include => [:sourcecode_type],
        :limit => @per_page,
        :offset => @offset
      }
    
      @id = params[:client_id]
    
      @total_records = SourceCode.count query.clone.delete_if { |key, value| true if key == :limit }.delete_if { |key, value| true if key == :offset }
    
      unless params[:order_by].blank?
        query[:order] = params[:order_by].clone
        query[:order] << ' '+params[:order_direction] unless params[:order_direction].blank?
      end
    
      @order_by = params[:order_by] || false
      @order_direction = params[:order_direction] || 'asc'
      @current_order_direction = @order_direction.clone
      if @order_direction == 'asc'
        @order_direction = 'desc' 
      else
        @order_direction = 'asc'
      end
    
      @source = SourceCode.all(query)
        
    end
  
end
