class SourceCode < ActiveRecord::Base
  unloadable
  
  belongs_to :client
end
