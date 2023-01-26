class PostComment < ApplicationRecord

  # 最後に、PostCommentモデルに記述します。 UserモデルもPostImageモデルも関連付けられるのは1つのため、belongs_toを記述します。
  belongs_to :user
  belongs_to :post_image

end
