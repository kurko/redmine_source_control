class SourceCode < ActiveRecord::Base
  unloadable
  
  belongs_to :client
  belongs_to :sourcecode_type, :foreign_key => 'sourcecode_type_id'
  belongs_to :code_sector, :foreign_key => 'code_sector_id'
  
  accepts_nested_attributes_for :sourcecode_type
  accepts_nested_attributes_for :code_sector
  accepts_nested_attributes_for :client
  
  def sourcecode_type_attributes=(attribs)
      self.sourcecode_type = SourcecodeType.find(attribs[:id])
  end

  def code_sector_attributes=(attribs)
      self.code_sector = CodeSector.find(attribs[:id])
  end
  
end
