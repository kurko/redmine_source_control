class SourcecodeTypeCouldBeNull < ActiveRecord::Migration
  def self.up
    change_column :source_codes, :sourcecode_type_id, :int, :null => true
  end

  def self.down
    change_column :source_codes, :sourcecode_type_id, :int, :null => false
  end
end
