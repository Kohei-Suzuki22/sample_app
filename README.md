# Ruby on Rails チュートリアルのサンプルアプリケーション

https://app-rails-tutorial.herokuapp.com/

これは、次の教材で作られたサンプルアプリケーションです。
[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)
[Michael Hartl](http://www.michaelhartl.com/)著

## ライセンス

[Ruby on Rails チュートリアル](https://railstutorial.jp/)内にある
ソースコードはMITライセンスとBeerwareライセンスのもとで公開されます。

## 使い方

このアプリケーションを動かす場合は、まずはリポジトリを手元にクローンして
その後、次のコマンドで必要になる RubyGems をインストールします。
```
$ bundle install --without production
```

その後、データベースのマイグレーションを実行します。
```
$ rails db:migrate
```

最後に、テストを実行してうまく動いているかどうか確認してください。
```
$ rails test
```

テストが無事に通ったら、Railsサーバーを立ち上げる準備が整っているはずです。
```
$ rails server
```

詳しくは、[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)
を参考にしてください。
