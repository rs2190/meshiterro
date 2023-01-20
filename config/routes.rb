Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'

  # get 'post_images/new'
  # get 'post_images/index'
  # get 'post_images/show'

  # resources メソッドは、ルーティングを一括して自動生成してくれる機能

  # onlyオプションを使用することで、生成するルーティングを限定することができます。
  # この場合、only の後に配列で記述されている"new","index","show"のアクション以外は、ルーティングが行われません。
  resources :post_images, only: [:new, :index, :show]

  get '/homes/about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
