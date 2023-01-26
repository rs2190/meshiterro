class PostCommentsController < ApplicationController


  def create

    post_image = PostImage.find(params[:post_image_id])

    # こちらの記述の仕方は、以下のように記述したものと変わりません。

    # comment = PostComment.new(post_comment_params)
    # comment.user_id = current_user.id
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_image_id = post_image.id
    comment.save
    redirect_to post_image_path(post_image)

  end

  private

  # 投稿コメントのストロングパラメータ
  def post_comment_params

    params.require(:post_comment).permit(:comment)

  end

end