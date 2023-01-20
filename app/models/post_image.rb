class PostImage < ApplicationRecord

    # 1対１(単数枚画像投稿)で関連付けるという宣言
    # シンボルで指定するカラム名でそのデータを扱うので、わかりやすい名前にします。
    # （画像なら :image、動画なら :movie、アバターなら :avatar など）
    has_one_attached :image

end
