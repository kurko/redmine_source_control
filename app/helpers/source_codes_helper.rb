module SourceCodesHelper
  
  def link_to_with_filter field_label, field
		url = client_source_codes_path(:order_by => field, :order_direction => @order_direction)
    options = {}
    if @order_by == field
  		options[:class] = "current_filter"
  		
  		field_label << ' ▼' if @order_direction == 'asc'
  		field_label << ' ▲' if @order_direction == 'desc'
    end
    
		link_to field_label, url, options
  end
  
  def class_name_if_column_filtered field
    'current_column_filter' if @order_by == field
  end
end
