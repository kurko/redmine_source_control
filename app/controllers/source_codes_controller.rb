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
  
  # Called via Ajax
  def search
    
    params[:search][:field_name].each_with_index { |v, i|
      next if params[:search][:query][i.to_i].blank?
      query = params[:search][:query][i.to_i]
      @conditions[0] << " AND source_codes."+v+" LIKE _utf8 '%"+query+"%' COLLATE utf8_unicode_ci"
#      @conditions << query
    }
    
    logger.debug @conditions.inspect
    listing
    render "search", :layout => false
  end
  
  private
  
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
