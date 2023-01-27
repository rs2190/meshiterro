class FavoritesController < ApplicationController

  # いいね機能のコントローラを作成します。ターミナルで以下コマンドを実行します。

  # いいね機能では他のモデルにあるような詳細ページや一覧ページなどのViewが必要ないため
  # 今回はアクションを指定せずにコントローラを作成します。

  def create

    post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.new(post_image_id: post_image.id)
    favorite.save
    redirect_to post_image_path(post_image)

  end

  def destroy

    post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.find_by(post_image_id: post_image.id)
    favorite.destroy
    redirect_to post_image_path(post_image)

  end

  # なお、いいね機能も、indexアクションやnewアクションは作成しません。 コメント機能同様、投稿画像の詳細画面（/post_images/:id/）で実装します。

  # 続けて、app/controllersフォルダのfavorites_controller.rbファイルに、createアクションとdestroyアクションの中身を実装します。

  # 記事に「いいね」を付けて保存された後は、post_imagesのshowページへリダイレクトされるように設定します

end
