class Client < ActiveRecord::Base
  unloadable
  
  has_many :source_codes #, :class_name => 'SourceCode'
  
  accepts_nested_attributes_for :source_codes
end
