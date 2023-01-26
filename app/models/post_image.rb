class PostImage < ApplicationRecord

    # 1対１(単数枚画像投稿)で関連付けるという宣言
    # シンボルで指定するカラム名でそのデータを扱うので、わかりやすい名前にします。
    # （画像なら :image、動画なら :movie、アバターなら :avatar など）
    has_one_attached :image

    belongs_to :user

    # belongs_to とは

    # 今回も新たに、"belongs_to"というメソッドが出てきました。
    # "belongs to〜"とは、直訳すると「〜に属する」という意味です。

    # has_many の時と同様、"belongs_to :user"という記述を見ていきましょう。
    # 直訳すると、「ユーザーに属する」ということになります。

    # has_many とは逆に、1:N の「N」側にあたるモデルに、belongs_to を記載する必要があります。
    # belongs_to は、PostImage モデルから user_id に関連付けられていて、User モデルを参照することができます。
    # PostImage モデルに関連付けられるのは、1 つの User モデルです。
    # このため、単数形の「user」になっている点に注意しましょう。

    # PostImageモデル／PostCommentモデル(1:N)
    # 1つの投稿画像に対して、複数のコメントを設定できます。 これも、1:Nの関係です。
    has_many :Post_Comments, dependent: :destroy


    def get_image

        # get_imageというメソッドを作成しました。
        # これはアクションとは少し違い、特定の処理を名前で呼び出すことができるようになります。
        # PostImageモデルの中に記述することで、カラムを呼び出すようにこの処理（メソッド）を呼び出すことができるようになります。

        # 例えば、post_imagesテーブルでIDが1のデータを持っていて、そのデータから保存された画像を表示させたい場合
        # 以下のように記述することができます。

        # # ID:1のレコードを取得し、@post_imageに格納する
        # @post_image = PostImage.find(1)

        # # @post_imageに含まれるイメージを表示させるメソッドを実行する
        # # カラムのように、インスタンス変数の後に"."をつけて、その後にメソッド名を繋げる
        # @post_image.get_image

        # if image.attached?
        #     image
        # else
        #     'no_image.jpg'
        # end

        #  画像が存在しない場合に表示する画像をActiveStorageに格納する
        # 今回作成するMeshiterroでは、画像のサイズ変更をRailsで行います。

        # ですが、上記で記述したメソッドだとRailsで画像のサイズ変更を行うことができないため
        # no_image.jpgをActiveStorageに格納するためにコードを次のように書き換えます。
        # ※既に記述しているアソシエーションの部分は、そのまま残しておきましょう。

        # unless文は条件式が偽の場合の処理を記述
        unless image.attached?

            file_path = Rails.root.join('app/assets/images/no_image.jpg')

            image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')

        end

        image

        # このメソッドの内容は、画像が設定されない場合はapp/assets/imagesに格納されている
        # no_image.jpgという画像をデフォルト画像としてActiveStorageに格納し、格納した画像を表示するというものです。

    end

end
