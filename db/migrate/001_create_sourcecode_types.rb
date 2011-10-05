class CreateSourcecodeTypes < ActiveRecord::Migration
  def self.up
    create_table :sourcecode_types do |t|
      t.column :name, :string
    end
  end

  def self.down
    drop_table :sourcecode_types
  end
end
