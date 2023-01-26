Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'

  # 実施コマンド：rails g controller PostImages new index show
  # get 'post_images/new'
  # get 'post_images/index'
  # get 'post_images/show'

  # resources メソッドは、ルーティングを一括して自動生成してくれる機能

  # onlyオプションを使用することで、生成するルーティングを限定することができます。
  # この場合、only の後に配列で記述されている"new","index","show"のアクション以外は、ルーティングが行われません。
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do

    # コメントは、投稿画像に対してコメントされます。このため、post_commentsは、post_imagesに結びつきます。 以下のように親子関係になります。
    resources :post_comments, only: [:create]

    # 以下コマンドを実行し、実際にURLを確認しましょう。
    # 今回追記したpost_comments関連のルーティングは以下のようになります。

    # post_image_post_comments POST   /post_images/:post_image_id/post_comments(.:format)     post_comments#create

    # 親のresourcesで指定したコントローラ名に、子のresourcesで指定したコントローラ名が続くURLが生成されるのが確認できます。
    # このような親子関係を、「ネストする」と言います。
    # 上記のようなネストしたURLを作成することでparams[:post_image_id]でPostImageのidが取得できるようになります。


  end
  # get 'users/show'
  # get 'users/edit'

  resources :users, only: [:show, :edit, :update]

  get '/homes/about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
