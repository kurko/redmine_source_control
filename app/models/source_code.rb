class SourceCode < ActiveRecord::Base
  unloadable
  
  belongs_to :client
  belongs_to :sourcecode_type, :foreign_key => 'sourcecode_type_id'
  
  accepts_nested_attributes_for :sourcecode_type
  accepts_nested_attributes_for :client
  
  def sourcecode_type_attributes=(attribs)
      self.sourcecode_type = SourcecodeType.find(attribs[:id])
  end

end
