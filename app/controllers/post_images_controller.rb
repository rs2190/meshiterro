class PostImagesController < ApplicationController

  def new

    # データを受け取り新規登録するためのインスタンス作成
    # postimage.newではない。モデルのclass名（PostImage）.new が正しい。
    @post_image = PostImage.new

  end

  def index
  end

  def show
  end
end
