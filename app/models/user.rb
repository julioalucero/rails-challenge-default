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
end
