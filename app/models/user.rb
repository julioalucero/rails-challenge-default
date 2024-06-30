class User < ApplicationRecord
  STRING_LENGTH = 100
  EMAIL_LENGTH = 200
  PHONE_NUMBER_LENGTH = 20
  METADATA_LENGTH = 2000

  validates :email, presence: true, uniqueness: true, length: { maximum: EMAIL_LENGTH }
  validates :phone_number, presence: true, uniqueness: true, length: { maximum: PHONE_NUMBER_LENGTH }
  validates :password, presence: true, length: { maximum: STRING_LENGTH }
  validates :key, presence: true, uniqueness: true, length: { maximum: STRING_LENGTH }
  validates :account_key, uniqueness: true, allow_blank: true, length: { maximum: STRING_LENGTH }
  validates :metadata, length: { maximum: METADATA_LENGTH }

  scope :by_full_name, ->(full_name) { where('full_name ILIKE ?', "%#{full_name}%") if full_name.present? }
  scope :by_metadata,  ->(metadata)  { where('metadata ILIKE ?',   "%#{metadata}%") if metadata.present? }
  scope :by_email,     ->(email)     { where('email ILIKE ?',         "%#{email}%") if email.present? }
end
