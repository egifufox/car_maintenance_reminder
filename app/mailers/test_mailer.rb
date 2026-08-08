# frozen_string_literal: true

class TestMailer < ApplicationMailer
  def test_email
    mail(
      to: 'test@example.com',
      subject: 'メール送信テスト'
    )
  end
end
