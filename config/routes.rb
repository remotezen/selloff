Rails.application.routes.draw do

  get 'bids/new/:id' => 'bids#new', as: "bid_for"
  post 'bids/create/:product_id' => 'bids#create', as: "bidded_on"

  get 'bids/create'

  get 'bids/update'

  get 'bids/edit'

  get 'bids/index'

  get 'bids/show/:id' => 'bids#show', as: "current_bid"

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
