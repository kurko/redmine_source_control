class CreateSourceCodes < ActiveRecord::Migration
  def self.up
    create_table :source_codes do |t|
      t.column :source_name, :text
      t.column :sourcecode_type_id, :integer, :null => false
      t.column :complexity, :integer, :default => 3
      t.column :tables_involved, :text
      t.column :called_from, :text
      t.column :observation, :text
      t.column :line_numbers, :string
      t.column :active, :boolean
      t.column :activation_date, :date
      t.timestamps
    end
    
    add_index :source_codes, [:sourcecode_type_id], :unique => false
  end

  def self.down
    drop_table :source_codes
  end
end
