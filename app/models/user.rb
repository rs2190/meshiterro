
# 「:database_authenticatable, :registerable,」のように、devise の後ろに :（コロン）で始まる部分が devise の機能名です。

# :database_authenticatable（パスワードの正確性を検証）
# :registerable（ユーザ登録や編集、削除）
# :recoverable（パスワードをリセット）
# :rememberable（ログイン情報を保存）
# :validatable（email のフォーマットなどのバリデーション）

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy

end

# has_many とは
# 新しく"has_many"というメソッドがでてきました。
# "has_many"とは、直訳すると「たくさん持っている」という意味になります。
# プログラミングではありませんが、例えば英語だと以下のような意味になります。

# has many apples : たくさんりんごを持っている
# has many computers : コンピューターをたくさん持っている
# これを踏まえて、"has_many :post_images"という記述を見てみましょう。
# post_images 以外を日本語に直訳すると、「たくさん post_image を持っている」ということになります。

# ここでお伝えしたいことは、1:N の「1」側にあたるモデルに、has_many を記載する必要がある ということです。
# 1：N の関係とは「1 人のユーザーが、N 個投稿することができる」という状況を示していました。
# 言い換えると、「1 人のユーザーが、たくさん投稿することができる」ということになります。
# つまり、1 人のユーザーが何をたくさん持っているか？というのを定義するのが、この場合の"has_many"なのです。
# 「has_many :post_images」の後ろの「dependent: :destroy」の記述の意味も確認しましょう。
# この記述があると「1:Nの1側が削除されたとき、N側を全て削除する」という機能が追加されます。
# 今回であれば「Userが削除された時に、そのUserが投稿したPostImageが全て削除される」という処理になります。
# この記述がないと「Userが削除されたときに、誰が投稿したか分からないPostImageが残る」という状態になってしまい、エラーになります。
# 今回はUserを削除する機能は実装しないため、この記述を付けなくても実際の動作は変わりませんが、
# ほとんどの場合「has_many」には「dependent: :destroy」を付けて実装するのでセットで覚えておきましょう。