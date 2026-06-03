class User < ApplicationRecord
  has_secure_password

  has_many :projects, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  def generate_password_reset_token!
    update!(
      reset_password_token: SecureRandom.urlsafe_base64(32),
      reset_password_sent_at: Time.current
    )
  end

  def password_reset_token_valid?
    reset_password_sent_at.present? && reset_password_sent_at > 2.hours.ago
  end

  def clear_password_reset_token!
    update!(
      reset_password_token: nil,
      reset_password_sent_at: nil
    )
  end

  def as_json(options = {})
    super(options.except(:password_digest))
  end
end