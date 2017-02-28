# sunset project

私の人生がここにある

## 開発環境構築

各種ライブラリをインストールしてください.

### iOS 関連のライブラリのインストール
### carthage

1. Carthageをインストールする
2. リポジトリをクローン
3. ルートで`carthage bootstrap --platform iOS`

開発中にライブラリをアップデートしたい場合には, 以下のコマンドを実行してください.
```
carthage update 対象パッケージ名 --platform iOS
```


### cocoapods

1. リポジトリのルートにて `bundle install --path vendor/bundle`
2. `bundle exec pod repo update`
3. `bundle exec pod install`

### mergepbx

1. 下記のコマンドを実行([詳細](http://qiita.com/kaneshin/items/1deebde685c973fda6b8))

```
brew install mergepbx
```

### その他

### fastlane
タスクランナーとして, fastlane を使用しています.
fastlane は cocoapods のインストール時に一緒にインストールされているはずです.

設定ファイルは `fastlane/` 以下にあります.  
`Fastfile` において, 各ステップで定義したタスクは以下のようにして実行することができます.

```ruby
fastlane タスク名
```

### 各種キーについて

`.env`ファイルを用いて, Fabric や Twitter のキーを管理しています.  
プロジェクトの `Run script` のステップやプログラム内で上記のファイルから各種キーを環境変数として読み込んでいるので, このファイルは必須になります.

`Cocoapods-keys` というライブラリでこれを実現しています. 以下のコマンドにより, 各種キーが定義されていることを確認してください.

```shell
1. cp .env_template .env
2. キーの中身を埋める
3. bundle exec pod keys
```

### ビルド
xcworkspace ファイルをオープンしてアプリをビルドしてください.
```shell
open sunset.xcworkspace
```

ここまでのステップを実行すると, アプリをビルドできる状態になっています.  
もしビルドできない際には, `Clean Build Folder` をするとうまくいくかもしれません.
(`command + shift + option + k` もしくは Xcode の Project メニューにある clean を, option を押しながら実行)
