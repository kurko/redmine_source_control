class AddClientIdToSourceCodes < ActiveRecord::Migration
  def self.up
    add_column :source_codes, :client_id, :integer
    add_index :source_codes, [:client_id]
  end

  def self.down
    remove_column :source_codes, :client_id
  end
end
