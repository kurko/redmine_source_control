class PopulateSourceCodeTypesDb < ActiveRecord::Migration
  def self.up
    SourcecodeType.find_or_create_by_name('Relatório')
    SourcecodeType.find_or_create_by_name('Rotina')
    SourcecodeType.find_or_create_by_name('Gatilho')
    SourcecodeType.find_or_create_by_name('Função')
    SourcecodeType.find_or_create_by_name('Ponto de Entrada')
    SourcecodeType.find_or_create_by_name('Validação de Usuário')
    SourcecodeType.find_or_create_by_name('Validação de Campo')
  end

  def self.down
    SourcecodeType.all.each { |e| e.destroy }
  end
end
