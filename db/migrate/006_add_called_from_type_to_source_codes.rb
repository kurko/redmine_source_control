class AddCalledFromTypeToSourceCodes < ActiveRecord::Migration
  def self.up
    add_column :source_codes, :code_sector, :string
  end

  def self.down
    remove_column :source_codes, :code_sector
  end
end
