class AddMenuToSourcetypes < ActiveRecord::Migration
  def self.up
    SourcecodeType.find_or_create_by_name('Menu')
  end

  def self.down
    SourcecodeType.find_by_name('Menu').each { |e| e.destroy }
  end
end
