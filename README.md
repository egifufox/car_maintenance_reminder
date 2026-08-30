# MechaniCare

[![CI](https://github.com/egifufox/car_maintenance_reminder/actions/workflows/ci.yml/badge.svg)](https://github.com/egifufox/car_maintenance_reminder/actions/workflows/ci.yml)

車のメンテナンス管理アプリケーション

## サービスURL
https://car-maintenance-reminder.onrender.com

![OGP画像](app/assets/images/ogp.png)

## サービス概要
車のメンテナンス時期を忘れがちな車オーナーに、整備士の知識に基づいた適切なタイミングでのリマインド機能を提供する車両点検管理Webアプリケーションです。

## 開発背景
整備士として働いていた経験から、多くの車オーナーが「オイル交換、いつやったっけ？」「複数台持ってるけど管理が大変」「車検まだ大丈夫だと思ってた」といった問題を抱えているのを目の当たりにしてきました。

**適切なタイミングでのメンテナンスリマインドにより、車の寿命を延ばし、安全な運転をサポートしたい** という思いでこのサービスを作りました。

## ターゲットユーザー
### メインターゲット：車を大切にしたい個人オーナー
- 車検は受けるが、日常メンテナンスのタイミングが曖昧
- 「オイル交換っていつだっけ？」「タイヤ交換時期がわからない」が口癖
- メンテナンス費用は惜しまないが、適切なタイミングを知りたい

### サブターゲット：複数台管理が必要な人
- 家族の車、仕事用の車など、複数台を管理している人
- メンテナンス時期がバラバラで把握しきれない

## 主な機能
### **実装済み機能**
#### **ユーザー機能**
- ✅ ユーザー登録・ログイン機能（Devise）
- ✅ パスワードリセット機能

#### **車両管理機能**
- ✅ 車両情報の登録・編集・削除機能
- ✅ 複数車両対応
- ✅ 車両タイプ別の推奨交換時期設定（ガソリン車：5,000km / ハイブリッド車：10,000km）

#### **オイル交換記録機能**
- ✅ オイル交換記録の登録・編集・削除機能
- ✅ 次回オイル交換時期の自動計算機能（走行距離・期間ベース）

#### **その他**
- ✅ レスポンシブデザイン対応
- ✅ 利用規約・プライバシーポリシーページ
- ✅ 使い方ページ
- ✅ ページネーション
- ✅ CI/CD環境（GitHub Actions）
- ✅ コード品質管理（Rubocop）
- ✅ 静的OGP設定
- ✅ Googleログイン機能
- ✅ メール通知機能（オイル交換時期のリマインド）

## 画面イメージ
### トップページ
[![Image from Gyazo](https://i.gyazo.com/43f35cc6c50838c529c7a6ad42d73b2e.png)](https://gyazo.com/43f35cc6c50838c529c7a6ad42d73b2e)

### 車両一覧ページ
[![Image from Gyazo](https://i.gyazo.com/97115d23ab54b5ba6d1e50ce8355f144.png)](https://gyazo.com/97115d23ab54b5ba6d1e50ce8355f144)

### オイル交換記録ページ
[![Image from Gyazo](https://i.gyazo.com/35c0949ca606dc63ab826f1e8a1e2da5.png)](https://gyazo.com/35c0949ca606dc63ab826f1e8a1e2da5)

### 使い方ページ
[![Image from Gyazo](https://i.gyazo.com/42fa5782ba4c54ba38b1f7fd7c0fa01f.png)](https://gyazo.com/42fa5782ba4c54ba38b1f7fd7c0fa01f)


## 使用技術
### **フロントエンド**
- Hotwire（Turbo Drive）
- Importmap
- Bootstrap 5

### **バックエンド**
- Ruby 3.1.4
- Ruby on Rails 7.0.10
- PostgreSQL 14

### **認証・国際化**
- Devise（認証機能）
- OmniAuth（Googleログイン機能。CSRF対策も実装済み）
- Rails I18n（国際化対応）
- Enum Help（enumの日本語化）

### **ページネーション**
- Kaminari
- Bootstrap5 Kaminari Views（ページネーションUIのBootstrap5対応）

### **開発環境**
- Docker
- RSpec（テストフレームワーク）
- FactoryBot（テストデータ作成）
- Capybara / Selenium-webdriver（システムテスト）
- Dotenv (環境変数管理)
- Rubocop（コード品質管理）
- Brakeman（セキュリティ監査）
- Letter Opener Web（メールプレビュー）

### **CI/CD**
- Github Actions

### **インフラ・デプロイ**
- Render（本番環境）
- Mailgun（メール送信）

## 技術選定理由
### フロントエンド
Hotwire・ImportmapはRails7のデフォルト構成であるため、まずはこの標準構成を採用しました。開発を進める中で、SPAフレームワークを別途学習・導入せずに動きのあるUIを実装できる点、Webpackerのようなビルド環境構築の手間がかからない点など、実務的なメリットも実感できました。
Bootstrap5は使い慣れていたことに加え、コンポーネントが豊富で実装スピードを優先できる点が卒業制作の限られた期間に合っていました。

### バックエンド
Ruby on Railsは「設定より規約」という思想により、少人数・短期間での開発に向いています。またDeviseやKaminariなど実績のあるGemが豊富に存在し、認証やページネーションといった機能を安全かつ効率的に実装できる点も選定理由の一つです。MVCアーキテクチャにより責務が明確に分かれているため、機能追加時の見通しも良く、個人開発でも保守性を保ちやすいと考えました。

### 認証
認証機能には、Railsで広く使われている実績のあるDeviseを採用しました。
Deviseはメールアドレス/パスワードによる認証を簡易的かつ安全に実装できるだけでなく、OmniAuthableモジュールを標準でサポートしているため、外部認証(ソーシャルログイン)への拡張が容易な点も採用理由の一つです。

この特性を活かし、GoogleログインをOmniAuthで実装しました。
Googleログインを導入することで、ユーザーが個別にパスワードを設定・管理する必要がなくなり、
セキュリティリスクとユーザーの手間を同時に減らすことができます。Google側で二段階認証などの
セキュリティ管理がされているため、自前でパスワード管理機能を実装するより安全性が高い点も
導入の決め手になりました。

また、OmniAuthは標準の実装だとCSRF対策(GETリクエストで認証フローが開始できてしまう問題)が
弱いという課題があるため、`omniauth-rails_csrf_protection` gemを導入し、
Railsのauthenticity_tokenによるCSRF対策を組み込んでいます。

### ページネーション
Rails標準にはページネーション機能がなくgemが必要ため、kaminariを採用しました。pagyに比べて、Bootstrap5対応のViewが公式で用意されていて実装が早かったです。

### 開発環境
チーム開発を想定した際に「環境差異によるバグ」を防ぐため、またRUNTEQのカリキュラムで扱っており実績があったためDockerを採用しました。ホストOSに依存せず誰でも同じ開発環境を再現できる点も、個人開発からチーム開発への拡張性を考えた際のメリットです。

### CI/CD
「実行し忘れる」「ローカルでは通ったが他の人の環境では通らない」という問題を防ぐため、mainへのpush・PR作成時にテスト・Lintを自動実行するCIを導入しました。
当初はpushをトリガーに即デプロイする構成にしていましたが、この方法だとテストが失敗していてもデプロイが実行されてしまうという課題がありました。そこで、CI(テスト・Lint)が成功した場合のみデプロイを実行する構成に変更しました。（別ファイルのワークフローを連携させるworkflow_runトリガーを採用）。CIの実行結果(conclusion)がsuccessの場合のみデプロイジョブを実行する条件を加えることで、「テストが通った時だけ本番にデプロイされる」安全な構成にしています。

### インフラ・デプロイ
Renderを選定した理由は、無料枠があり個人開発でコストをかけずに本番環境を構築できること、またPostgreSQLのマネージドサービスを利用できることです。またSendGridと異なり無料枠があったため、Mailgunを選定しました。

## ER図
[![Image from Gyazo](https://i.gyazo.com/d65a33b668a9c77c2110e8c387f3ab4a.png)](https://gyazo.com/d65a33b668a9c77c2110e8c387f3ab4a)

### テーブル構成は大きく分けて、「ユーザー情報」 「車両情報」 「オイル交換記録」 の3つに分類されます。


## セットアップ方法
### **前提条件**
- Docker
- Docker Compose

### **起動手順**
```bash
# リポジトリのクローン
git clone https://github.com/egifufox/car_maintenance_reminder.git
cd car_maintenance_reminder

# Dockerコンテナの起動
docker compose up -d

# データベースの作成
docker compose exec web bin/rails db:create

# マイグレーション実行
docker compose exec web bin/rails db:migrate

# サーバーの起動
docker compose up
```

### アクセス
http://localhost:3000

### テストの実行
```bash
# RSpecの実行
docker compose exec web bundle exec rspec

# Rubocopの実行
docker compose exec web bundle exec rubocop
```

**一般的なCRUD以外の実装機能**

#### **次回交換時期の自動計算（MVPのコア機能）**
オイル交換の履歴から、次回交換時期を自動計算して表示。

**実装方針**：
- **走行距離ベース**: 前回交換から5,000km経過で通知
（ハイブリッド車の場合は10,000km）
- **期間ベース**: 前回交換から1年経過で通知
- **両方の条件**: いずれか早い方で判定

**使用技術**：
- Railsのモデルメソッドで実装（`Vehicle#km_until_next_oil_change`等）
- 車両タイプ（ガソリン車/ハイブリッド車）に応じた計算ロジック

**実装イメージ**：
```ruby
# app/models/vehicle.rb
class Vehicle < ApplicationRecord
  has_many :oil_change_records, dependent: :destroy
  
  # 最後のオイル交換記録
  def last_oil_change
    oil_change_records.order(changed_at: :desc).first
  end
  
  # 車両タイプに応じた次回交換までの走行距離
  def oil_change_interval_km
    hybrid? ? 10_000 : 5_000
  end
  
  # 次回交換まであと何km?
  def km_until_next_oil_change
    return nil if last_oil_change.blank?
    oil_change_interval_km - (current_mileage - last_oil_change.mileage)
  end
  
  # 次回交換まであと何日?
  def days_until_next_oil_change
    return nil if last_oil_change.blank?
    target_date = last_oil_change.changed_at + 1.year
    (target_date - Date.today).to_i
  end
  
  # 交換時期が近い?(1000km以内または1ヶ月以内)
  def needs_oil_change_soon?
    km_until_next_oil_change.present? && km_until_next_oil_change <= 1000 ||
    days_until_next_oil_change.present? && days_until_next_oil_change <= 30
  end
end
```

## こだわった実装
### こだわった実装は以下の機能になります。
- ユーザー認証機能
- SNSでURLをシェアした際に表示される画像を設計
- 整備士の経験を活かした機能設計
- 複数車両を一括管理できる設計
- ユーザビリティの向上

### ユーザー認証機能
オイル交換の記録アプリという特性上、ユーザーが「面倒だから」と離脱してしまうと本末転倒だと考えました。そのため、メールアドレスや
パスワードの入力を省略できるGoogleログインを実装し、ログインボタン1つで利用を開始できるようにしています。

ログインリンクをPOSTメソッドでアクセスする必要があることに気づかず、GETでアクセスしてしまいエラーが発生していました。Railsのルーティングを
確認したところ、Deviseのログイン処理がPOSTを前提としていたため、`button_to` を使ってPOSTリクエストを送るように修正し解決しました。

### 整備士の経験を活かした機能設計
整備士として実際の現場で働く中で、「走行距離だけで判断すると、あまり車に乗らない人は長期間オイル交換をしない可能性がある」「期間だけで判断すると、年間走行距離が多い人は適切な時期より遅くなってしまう」という課題を数多く見てきました。
この実務経験を活かし、単なる記録アプリではなく「走行距離」と「期間」の両方を計算し交換時期を自動で判断してくれるよう設計しました。
また、ガソリン車とハイブリッド車では交換目安が異なるため、車両タイプによって判定基準を切り替えています。

```ruby
# app/models/vehicle.rb（抜粋）
def oil_change_interval_km
  hybrid? ? 10_000 : 5_000
end
```
ハイブリッド車はガソリン車に比べてエンジンの停止している割合が高いため、ガソリン車よりもオイル交換のスパンを長くしております。
この実務知識を反映し、車両タイプごとに異なる交換基準(10,000km/5,000km)を設定しました。

```ruby
# app/models/vehicle.rb（抜粋）
def km_until_next_oil_change
  return nil if last_oil_change.blank?
  oil_change_interval_km - (current_mileage - last_oil_change.mileage)
end
```
「(交換基準の距離)-(前回交換時からの走行距離)」で、次回交換まであと何km走れるかを算出しています。

```ruby
# app/models/vehicle.rb（抜粋）
def days_until_next_oil_change
  return nil if last_oil_change.blank?
  target_date = last_oil_change.changed_at + 1.year
  (target_date - Date.today).to_i
end
```
「前回のオイル交換から1年後の日付」を計算し、「今日から見て、あと何日でその日が来るか」を算出しています。


```ruby
# app/models/vehicle.rb（抜粋）
def last_oil_change
  oil_change_records.order(changed_at: :desc).first
end
  
# 交換時期が近い?(1000km以内または1ヶ月以内)
def needs_oil_change_soon?
  km_until_next_oil_change.present? && km_until_next_oil_change <= 1000 ||
  days_until_next_oil_change.present? && days_until_next_oil_change <= 30
end
```

```ruby
# app/views/vehicles/show.html.erb（抜粋）
<div class="text-muted small">走行距離ベース</div>
<div class="fs-5 fw-bold">
  <% if @vehicle.km_until_next_oil_change > 0 %>
    あと <%= number_with_delimiter(@vehicle.km_until_next_oil_change) %> km
  <% else %>
    <span class="text-danger">
      <%= number_with_delimiter(@vehicle.km_until_next_oil_change.abs) %> km超過
    </span>
  <% end %>
</div>

<div class="text-muted small">期間ベース</div>
<div class="fs-5 fw-bold">
  <% if @vehicle.days_until_next_oil_change > 0 %>
    あと <%= @vehicle.days_until_next_oil_change %> 日
　<% else %>
    <span class="text-danger">
      <%= @vehicle.days_until_next_oil_change.abs %> 日超過
    </span>
  <% end %>
</div>

<% if @vehicle.needs_oil_change_soon? %>
  <div class="alert alert-danger mt-3 mb-0">
    <i class="bi bi-exclamation-triangle-fill me-2"></i>
    <strong>オイル交換の時期が近づいています!</strong>
  </div>
<% end %>
```
`needs_oil_change_soon?`を定義することによって、次回オイル交換まで1000km以内または1ヶ月以内であれば警告表示が出るように実装しました。これは一般的にオイル交換の目安である5,000km/10,000kmに対して、1,000kmを余裕期間として設定しました。ユーザーが余裕を持って交換の予定を立てられるよう、少し早めに通知するようにしています。

距離ベース`km_until_next_oil_change`と期間ベース`def days_until_next_oil_change`を定義しており、前回オイル交換時の距離と日付を参照し比較するようにしております。

### 複数車両を一括管理できる設計
整備士として働く中で、お客さまが1台の車だけでなく、
家族の車や複数所有している車をまとめて管理したいというニーズを数多く見てきました。1台のみの管理に限定してしまうと実際の
利用シーンに合わないため、1ユーザーが複数の車両を登録・管理できる設計にしました。

車両ごとに走行距離やオイル交換履歴を個別に紐付けることで、
「どの車が、いつ交換時期を迎えるか」を一目で把握できるようにしています。

### ユーザビリティの向上
開発中に第三者から以下のフィードバックをいただきました。

- ログインまたは新規登録時に、パスワードが非表示なので自分の入力内容を確認できない
- 「かんたん3ステップ」の表示が進行状況が分かりにくい

#### 対応内容

**パスワード表示/非表示ボタンの実装**
ユーザーが自分の入力内容を確認できないまま送信してしまうと、
入力ミスに気づけずログインできない、というフィードバックをいただきました。
そのため、目のアイコンをクリックすることでパスワードの表示/非表示を
切り替えられるボタンを実装し、ユーザーが入力内容を確認できるように改善しました。

**ステップ表示のstepper化**
「かんたん3ステップ」は文章での説明のみだと、ユーザーが「今どの段階にいるのか」を
把握しづらいという課題がありました。そのため、進行状況を視覚的に示すstepperのUIに
変更し、現在地と残りのステップ数が一目で分かるように改善しました。

## 今後の開発について
今後、以下の機能を実装予定です。
- スマホのレスポンシブデザイン対応
- ダッシュボード機能（今月やるべきメンテナンス一覧）
- 車種別メンテナンス推奨項目
- 独自ドメイン設定
- なぜそのタイミングなのか等の解説ページ