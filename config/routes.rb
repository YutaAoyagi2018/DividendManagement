Rails.application.routes.draw do
  root to: "dividends#index"
  get '/dividends/pie_chart', to: 'dividends#pie_chart'
  get '/dividends/column_chart', to: 'dividends#column_chart'
  get '/dividends/line_chart', to: 'dividends#line_chart'
  resources :countories
  resources :dividends do
    collection {post :import}
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
