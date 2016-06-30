Rails.application.routes.draw do

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
