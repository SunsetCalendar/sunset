# sunset project

私の人生がここにある

## 開発環境構築

### carthage

1. Carthageをインストールする
2. リポジトリをクローン
3. ルートで`carthage update --platform iOS`

### Cocoapods, Cocoapods-keys

1. リポジトリのルートにて`bundle install`

### 各種キーについて

`.env`ファイルを用いて、FabricやTwitterのキーを管理しています。  
プロジェクトの`Run script`やプログラム内で、上記のファイルから各種キーを環境変数として読み込んでいるので、このファイルは必須になります。

`Cocoapods-keys`というライブラリを用いることで、`.env`で定義された環境変数をプロジェクトのコード内で使用することができます。以下の手順によって環境変数を使えるようにします。

1. キーが書かれた`.env`ファイルを用意
2. `pod install`

実行後、`pod keys`の出力結果より、キーが定義されていることを確認してください。  

### mergepbx

1. 下記のコマンドを実行([詳細](http://qiita.com/kaneshin/items/1deebde685c973fda6b8))

```
brew install mergepbx
```
