class PostImage < ApplicationRecord

    # 1対１(単数枚画像投稿)で関連付けるという宣言
    # シンボルで指定するカラム名でそのデータを扱うので、わかりやすい名前にします。
    # （画像なら :image、動画なら :movie、アバターなら :avatar など）
    has_one_attached :image

    belongs_to :user

end

# belongs_to とは

# 今回も新たに、"belongs_to"というメソッドが出てきました。
# "belongs to〜"とは、直訳すると「〜に属する」という意味です。

# has_many の時と同様、"belongs_to :user"という記述を見ていきましょう。
# 直訳すると、「ユーザーに属する」ということになります。

# has_many とは逆に、1:N の「N」側にあたるモデルに、belongs_to を記載する必要があります。

# belongs_to は、PostImage モデルから user_id に関連付けられていて、User モデルを参照することができます。
# PostImage モデルに関連付けられるのは、1 つの User モデルです。
# このため、単数形の「user」になっている点に注意しましょう。
