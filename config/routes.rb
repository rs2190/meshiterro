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

    # 今まではresourcesでしたが、ここでは、resourceとなっている点に注目してください。
    # 単数形にすると、/:idがURLに含まれなくなります。

    # コメント機能では「1人のユーザが１つの投稿に対して何度でもコメントできる」という仕様だったため、
    # destroyをする際にidを受け渡して「どのコメントを削除するのか」を指定する必要がありました。
    # destroyアクションの場合、URLは'/post_images/:post_image_id/post_comments/:id'のようになっており、URLの最後に/:idが含まれます。
    # コントローラで「params[:id]」と記述することで、このURLに含まれる:idを取得できるのでした。

    # しかし、いいね機能の場合は「1人のユーザーは1つの投稿に対して1回しかいいねできない」という仕様であるため、
    # destroyをする際にもユーザーidと投稿(post_image)idが分かれば、どのいいねを削除すればいいのかが特定できます。
    # そのため、いいねのidはURLに含める必要がない(params[:id]を使わなくても良い)ため、
    # resourcesではなくresourceを使ってURLに/:idを含めない形にしています。

    # このように、resourceは「それ自身のidが分からなくても、関連する他のモデルのidから特定できる」といった場合に用いることが多いです。
    resource :favorites, only: [:create, :destroy]

    # post_image_favorites DELETE /post_images/:post_image_id/favorites(.:format)                           favorites#destroy
    #                      POST   /post_images/:post_image_id/favorites(.:format)                           favorites#create

    # resourcesで指定したコントローラ名に、resourceで指定したコントローラ名が続くURLが生成されるのが確認できます。
    # resources(複数形)の場合ではdestroyアクションのURLは最後に/:idが付いていたことを思い出してください。
    # resourceにしたことで/:idがない形でURLが生成されているのが確認できます。

    # コメントは、投稿画像に対してコメントされます。このため、post_commentsは、post_imagesに結びつきます。 以下のように親子関係になります。
    resources :post_comments, only: [:create, :destroy]

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
