# README
## このアプリケーションについて
サッカーの試合情報を登録できるアプリケーションです。
主な機能は次の通りです。

### 試合結果 CRUD 機能
- 試合の結果をリーグごとに一覧表示できます。
- 試合の結果を登録したり、編集・削除できます。

### クラブ情報閲覧機能
- データベースに登録されているクラブの情報を、クラブ詳細画面から閲覧できます。
- クラブ詳細画面では、チームロゴや所属国などの情報が確認できます。
- そのほか、クラブに所属する選手も一覧できます。

### リーグ順位表閲覧機能
- リーグごとに、登録されている試合の結果を集計した順位表を閲覧できます。
- 順位表では、試合の勝敗に応じて付与され順位を決定する勝ち点や、消化済み試合数、ゴール数、失点数などを確認できます。

## About this application
It is an application that can register soccer match information.
The main functions are as follows.

### Match Results CRUD Function
- You can list the results of the match by league.
- You can register, edit, and delete match results.

### Club information browsing function
- You can view the club information registered in the database from the club details screen.
- On the club details screen, you can check information such as the team logo and country of affiliation.
― In addition, you can also list the players who belong to the club.

### League standings browsing function
― You can view the standings that summarize the results of the registered matches for each league.
― In the standings, you can check the points that are awarded according to the outcome of the match and determine the ranking, the number of games that have been digested, the number of goals, the number of goals, etc.

## 環境構築 / Installation

```
$ git clone git@github.com:kfukai23/football_info_for_refactoring.git
$ cd football_info_for_refactoring
$ bundle install
$ rails db:setup
$ rails s
```
