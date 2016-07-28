Rails.application.routes.draw do

  resources :product_attachments
  get 'searches/index'

  get 'bids/new'
  post 'bids/create'


  get 'bids/update'

  get 'bids/edit'

  get 'bids/index'

  get 'bids/show/:id' => 'bids#show', as: "current_bid"
  resources :products do
    get :autocomplete_product_name, on: :collection

  end

  resources :products
#rails g scaffold campaign name:string account:belongs_to
  #
=begin
    :binary
    :boolean
    :date
    :datetime
    :decimal
    :float
    :integer
    :primary_key
    :references
    :string
    :text
    :time
    :timestamp
=end
  devise_for :users
  root to: 'visitors#index'

end
