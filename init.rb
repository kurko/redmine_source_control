require 'redmine'

Redmine::Plugin.register :redmine_source_control do
  name 'Redmine Source Control plugin'
  author 'Alexandre de Oliveira'
  description 'Este é um plugin para catalogar códigos-fonte de projetos.'
  version '0.0.1'
  url '-'
  author_url 'http://twitter.com/kurko'
  
#  permission :source_control, { :source_control => [:index, :show] }, :public => true
  menu :top_menu, :source_control, { :controller => 'clients', :action => 'index' },
    :caption => 'SourceControl',
    #:after => :activity,
    :param => :project_id

end
