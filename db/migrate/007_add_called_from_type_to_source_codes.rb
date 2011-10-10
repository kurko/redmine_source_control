class AddCalledFromTypeToSourceCodes < ActiveRecord::Migration
  def self.up
    add_column :source_codes, :code_sector_id, :integer
  end

  def self.down
    remove_column :source_codes, :code_sector_id
  end
end
