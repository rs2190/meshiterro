class UsersController < ApplicationController

  def show

    @user = User.find(params[:id])

    # kaminari実装
    # @post_images = @user.post_images
    @post_images = @user.post_images.page(params[:page])

    # @post_imagesに関しては、見慣れない記述が出てきました。
    # これは、アソシエーションを持っているモデル同士の記述方法です。

    # 上記のように記述することで、特定のユーザ（@user）に関連付けられた投稿全て（.post_images）を取得し
    # @post_imagesに渡す という処理を行うことができます。
    # 結果的に、全体の投稿ではなく、個人が投稿したもの全てを表示できます

    # 【アソシエーションで取得できる情報の違い】

    # 前の章で、@post_image.userという書き方をしたのを思い出してみましょう。
    # この場合、特定の投稿画像(@post_image)に紐づいたユーザーの情報を取得するために使いました。
    # 投稿画像に対して決まるユーザーは1人だけなので、ここで取得できるデータはユーザー1人分です。

    # 一方で、@user.post_imagesの場合は、ユーザーが投稿した投稿画像を全て取得します。
    # したがって、データが投稿画像の数だけ、複数存在するという形になります。
    # 言い換えると、取得できるデータは投稿画像データN個(投稿している数だけ)分となります。

    # @user.post_imagesに格納されているデータは複数あるため
    # @post_images.user.id,@post_images.user.nameのように
    # 関連づけられているモデルのカラムを操作することはできません。
    # each文を使用して、一つずつデータを確認した上で、カラムを操作する必要があります

  end

  def edit

    @user = User.find(params[:id])

  end

  def update

    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)

  end

  private

  def user_params

    params.require(:user).permit(:name, :profile_image)

  end

end
