class PostImagesController < ApplicationController

  def new

    # データを受け取り新規登録するためのインスタンス作成
    # postimage.newではない。モデルのclass名（PostImage）.new が正しい。
    @post_image = PostImage.new

  end

  # 投稿データの保存
  def create

    # 投稿するデータを PostImage モデルに紐づくデータとして保存する準備をしていて
    # フォームに入力されたデータ(shop_name や caption,image など)が、@post_image に格納されることになっています。
    @post_image = PostImage.new(post_image_param)

    # current_user について
    # current_user は、コードに記述するだけで、ログイン中のユーザーの情報を取得できる便利な記述です。
    # ヘルパーメソッドと呼ばれるものの一種で、devise をインストールすることで使えるようになります。

    # この current_user は、ログイン中のユーザー情報を取得することができるため、current_user.id と記述することで
    # ログインユーザーの id を取得することができます。
    # また、User モデルに紐付いたカラムの情報も取得できるため、例えば以下のような使い方ができます。

    # current_user.name : 今ログインしているユーザーの名前を表示
    # current_user.email : 今ログインしているユーザーのメールアドレスを表示
    # ※ devise のヘルパーメソッドであるため、devise を導入しないと使用することができません。

    # @post_image.user_id は、PostImage モデルに紐づいた user_id の値を操作できる
    # current_user は、現在ログイン中のユーザーに関する情報を取得できる
    @post_image.user_id = current_user.id

    # ◆ここで、user_id が何であったかを思い出してみましょう。◆
    #   user_id は、PostImage モデルを作成時に作ったカラムであること
    #   user_id は、ユーザーを ID で特定するために使用するカラムであること

    #   つまり、 user_idは画像投稿を行う際に、「どのユーザーが投稿したのか」を「ユーザーの ID で判断する」ためのカラムであることがわかります。

    #   改めて説明となりますが、@post_image は、PostImage.new によって生成された、PostImage の空のモデルです。
    #   空のモデルでは、PostImage モデルで定義したカラムを@post_image.user_idのように、"[モデル名].[カラム名]"
    #   という形で繋げることで、保存するカラムの中身を操作することができます。

    # 2 つ前の章で作成した PostImage モデルには、以下のカラムがありました。

    # カラム名	データ型	カラムの説明
    # id	      integer	  投稿画像を識別する ID
    # shop_name	string	  お店の名前
    # caption	  text	    画像の説明
    # user_id	  integer	  投稿したユーザを識別する ID（users テーブルの id を保存する）

    # つまり、この場合は次のようになります。
    #   @post_image.shop_name : お店の名前
    #   @post_image.caption : 画像の説明
    #   @post_image.user_id : 投稿したユーザを識別する ID

    # これらをコードの中に記述することで、PostImage モデルに紐づくカラムの値を取得したり、逆に値を代入することができるということになります。

    # @post_image.save

    if @post_image.save

      # 一覧画面へ遷移する。
      redirect_to post_images_path

    else

      render :new

    end

  end

  def index

    # 投稿一覧で表示する全ての画像をコントローラで取得します。
    # post_images_controller.rbファイルのindexに、以下のコードを記述します。
    # これで、タイムライン上に表示する投稿データを取得できるようになります。

    @post_images = PostImage.all

  end

  def show

    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new

  end

  def destroy

    # 削除するPostImageレコードを取得
    @post_image = PostImage.find(params[:id])
    # PostImageレコードを削除
    @post_image.destroy
    # 一覧画面へ遷移する。
    redirect_to post_images_path

  end

  private

  # 投稿データのストロングパラメータ
  def post_image_param

    params.require(:post_image).permit(:shop_name, :caption)

    # ストロングパラメータの設定
    # post_image_paramsメソッドでは、フォームで入力されたデータが、投稿データとして許可されているパラメータかどうかをチェックしています。

    # PostImageモデルへ保存した後、投稿一覧画面へリダイレクトします。
    # ※この時点で投稿すると投稿一覧画面が存在しないためエラーになります。投稿一覧画面は次で作成していきます。

  end

end
