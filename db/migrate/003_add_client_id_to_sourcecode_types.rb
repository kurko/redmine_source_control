class AddClientIdToSourcecodeTypes < ActiveRecord::Migration
  def self.up
    add_column :sourcecode_types, :client_id, :integer
    add_index :sourcecode_types, [:client_id]
  end

  def self.down
    remove_column :sourcecode_types, :client_id
  end
end
