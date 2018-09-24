Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: 'api' do
    namespace :v1, path: '' do
      get '/tree/:name', to: 'tree_pruning#tree'
    end
  end
end
