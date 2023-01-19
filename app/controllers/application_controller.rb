
# このファイルの記載について以下を参照。
# https://qiita.com/ohnitakahiro/items/4487aed43fa264ddcdee

class ApplicationController < ActionController::Base


  before_action :configure_permitted_parameters, if: :devise_controller?

  # before_action ：アクションの前に処理を実行

  # 使い方
  # before_action(アクション名, only: 実行するアクション=nil, except: 実行しないアクション=nil, if: 実行する条件を指定=nil, unless: 実行されない条件を指定=nil, ブロック)

  # :devise_contoller?とは
  # deviseを生成した際にできるヘルパーメソッドの一つで、deviseにまつわる画面に行った時に、という意味がある。
  # こうすることで全ての画面でconfigure_permitted_parametersが起動する。

  # つまりもしそれがdeviseのコントローラーだったら（devise_controller?というメソッドの返り値がtrueだったら）configure_permitted_parametersを呼ぶ。

  # このように記述することで、devise利用の機能（ユーザ登録、ログイン認証など）が使われる前に
  # configure_permitted_parametersメソッドが実行されます。

  # protectedについて
  # https://qiita.com/tbpgr/items/6f1c0c7b77218f74c63e

  # サインイン後の遷移先
  def after_sign_in_path_for(resource)

    about_path

    # after_sign_in_path_forはDeviseが用意しているメソッドで、サインイン後にどこに遷移するかを設定しているメソッドです。

    # after_sign_in_path_forは、Deviseの初期設定ではroot_pathになっています。サインイン後にルートパスに遷移していたのはこのためです。
    # 上記のような記述をすることで、初期設定を上書きすることができます。
    # 今回はAboutページへ遷移するように設定しました。

  end

  # サインアウト後の遷移先
  def after_sign_out_path_for(resource)

    about_path

    # after_sign_out_path_forはafter_sign_in_path_forと同じくDeviseが用意しているメソッドで、サインアウト後にどこに遷移するかを設定するメソッドです。

    # Deviseのデフォルトは同じくroot_pathになっています。サインアウト後にルートパスに遷移していたのはこのためです。
    # 今回はAboutページへ遷移するように設定しました

  end

  # after_sign_in_path_for,after_sign_out_path_for について以下を参照。
  # https://qiita.com/Tatty/items/a9759755e562ac4693ec

  # 使い方

  # アカウント登録後のリダイレクト先
  # def after_sign_up_path_for(resource)
  #   リダイレクト先のパス(root_pathとかusers_pathとか)
  # end

  # アカウント編集後のリダイレクト先
  # def after_update_path_for(resource)
  #   リダイレクト先のパス
  # end

  protected

  # デバイス版のストロングパラメーター
  def configure_permitted_parameters


    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

    # devise_parameter_sanitizer について
    # https://qiita.com/kaito121855/items/e1a80da8557258c497dc

    # devise_parameter_sanitizer とは
    # devise（Gem）のUserモデルに関わる「ログイン」「新規登録」などのリクエストからパラメーターを取得できるようになるメソッド。
    # また、新しく追加したカラムをdeviseに定義されているストロングパラメーターに含めたい場合は、
    # permitメソッドを用いることで含めることができる。

    # デバイスでは初期設定でメールアドレスとパスワードしか許されていない。
    # ここを編集することでユーザーネームなどを入れることができる。

    # configure_permitted_parametersメソッドでは、devise_parameter_sanitizer.permitメソッドを使うことで
    # ユーザー登録(sign_up)の際に、ユーザー名(name)のデータ操作を許可しています。
    # privateは記述をしたコントローラ内でしか参照できません。
    # 一方、protectedは呼び出された他のコントローラからも参照することができます。

    # 使い方
    # devise_parameter_sanitizer.permit(:deviseの処理名, keys: [:許可するキー])
    #
    # deviseの処理名	役割
    # :sign_in	      ログインの処理を行う時
    # :sign_up	      新規登録の処理を行う時
    # :account_update	アカウント情報更新の処理を行う時

  end

end