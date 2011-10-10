class CreateCodeSectors < ActiveRecord::Migration
  def self.up
    create_table :code_sectors do |t|
      t.column :name, :string
    end
    
    CodeSector.find_or_create_by_name('Menu')
    CodeSector.find_or_create_by_name('Rotina')
    CodeSector.find_or_create_by_name('Job')
    CodeSector.find_or_create_by_name('Schedule')
    CodeSector.find_or_create_by_name('Dicionário')
  end

  def self.down
    drop_table :code_sectors
  end
end
