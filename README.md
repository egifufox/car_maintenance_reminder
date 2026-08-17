# MechaniCare

[![CI](https://github.com/egifufox/car_maintenance_reminder/actions/workflows/ci.yml/badge.svg)](https://github.com/egifufox/car_maintenance_reminder/actions/workflows/ci.yml)

車のメンテナンス管理アプリケーション

## 公開URL
https://car-maintenance-reminder.onrender.com

## サービス概要
車のメンテナンス時期を忘れがちな車オーナーに、整備士の知識に基づいた適切なタイミングでのリマインド機能を提供する車両点検管理Webアプリケーションです。

## このサービスへの思い
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

## 工夫した点
### **整備士の経験を活かした機能設計**
- 車両タイプ（ガソリン車/ハイブリッド車）に応じた推奨交換時期の自動計算
- 走行距離ベースと期間ベースの両方で交換時期を判定

### **ユーザビリティの向上**
- レスポンシブデザイン対応（スマホでも使いやすい）
- 複数車両の管理が簡単

### **コード品質の担保**
- RSpecによるテストカバレッジ
- Rubocopによるコード品質管理
- GitHub Actionsによる自動テスト

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
- ✅ CI/CD環境（GitHub Actions）
- ✅ コード品質管理（Rubocop）
- ✅ 静的OGP設定
- ✅ Googleログイン機能
- ✅ メール通知機能（オイル交換時期のリマインド）

### **今後実装予定の機能**
- [ ] スマホのレスポンシブデザイン対応
- [ ] ダッシュボード機能（今月やるべきメンテナンス一覧）
- [ ] 車種別メンテナンス推奨項目
- [ ] 独自ドメイン設定

## 使用技術
### **バックエンド**
- Ruby 3.1.4
- Ruby on Rails 7.0.10
- PostgreSQL 14

### **フロントエンド**
- Hotwire（Turbo, Stimulus）
- Importmap
- Bootstrap 5

### **認証・国際化**
- Devise（認証機能）
- Rails I18n（国際化対応）
- Enum Help（enumの日本語化）

### **ページネーション**
- Kaminari

### **開発環境**
- Docker / Docker Compose
- RSpec（テストフレームワーク）
- FactoryBot（テストデータ作成）
- Rubocop（コード品質管理）
- Brakeman（セキュリティ監査）
- Letter Opener Web（メールプレビュー）

### **インフラ・デプロイ**
- Render（本番環境）

## 画面イメージ
### トップページ
[![Image from Gyazo](https://i.gyazo.com/7c0f9d94a0fe9b1d6987b5dd0aff6639.png)](https://gyazo.com/7c0f9d94a0fe9b1d6987b5dd0aff6639)

### 車両一覧ページ
[![Image from Gyazo](https://i.gyazo.com/9139465f56e59e01ded559714887a7a7.png)](https://gyazo.com/9139465f56e59e01ded559714887a7a7)

### オイル交換記録ページ
[![Image from Gyazo](https://i.gyazo.com/963990359b7361194ead9dc55923770f.png)](https://gyazo.com/963990359b7361194ead9dc55923770f)

### 使い方ページ
[![Image from Gyazo](https://i.gyazo.com/2e19523898e3f945216a61500de7c0f5.png)](https://gyazo.com/2e19523898e3f945216a61500de7c0f5)

## ER図
[![Image from Gyazo](https://i.gyazo.com/d65a33b668a9c77c2110e8c387f3ab4a.png)](https://gyazo.com/d65a33b668a9c77c2110e8c387f3ab4a)

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
    vehicle_type == 'hybrid' ? 10_000 : 5_000
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