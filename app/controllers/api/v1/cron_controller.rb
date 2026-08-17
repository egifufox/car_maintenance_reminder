# frozen_string_literal: true

module Api
  module V1
    class CronController < ApplicationController
      # CSRF保護を無効化（外部からのリクエストのため）
      skip_before_action :verify_authenticity_token

      # 簡易的な認証（環境変数でトークンを設定）
      before_action :authenticate_cron_request

      def send_oil_change_reminders
        Rails.logger.info '=== Cron: オイル交換リマインドメール送信開始 ==='

        # Rakeタスクを実行
        result = run_reminder_task

        Rails.logger.info '=== Cron: オイル交換リマインドメール送信完了 ==='

        render json: result, status: :ok
      rescue StandardError => e
        Rails.logger.error "Cron job error: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")

        render json: {
          status: 'error',
          message: e.message
        }, status: :internal_server_error
      end

      private

      def authenticate_cron_request
        # 環境変数に設定したトークンで認証
        provided_token = request.headers['X-Cron-Token']
        expected_token = ENV.fetch('CRON_TOKEN', nil)

        return if provided_token.present? && provided_token == expected_token

        Rails.logger.warn 'Unauthorized cron request attempt'
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end

      def run_reminder_task
        # 交換時期が近い車両を取得
        vehicles = Vehicle.includes(:user, :oil_change_records)
                          .select(&:needs_oil_change_soon?)

        sent_count = 0
        failed_count = 0

        vehicles.each do |vehicle|
          OilChangeReminderMailer.reminder(vehicle.user, vehicle).deliver_now
          Rails.logger.info "✓ メール送信成功: #{vehicle.user.email} - #{vehicle.name}"
          sent_count += 1
        rescue StandardError => e
          Rails.logger.error "✗ メール送信失敗: #{vehicle.user.email} - #{e.message}"
          failed_count += 1
        end

        {
          status: 'success',
          message: 'Reminders sent',
          sent_count: sent_count,
          failed_count: failed_count,
          total_vehicles: vehicles.count
        }
      end
    end
  end
end
