# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    phone_number { rand(10**9..10**10) }
    full_name { 'Joe Smith' }
    password { 'password' }
    key { SecureRandom.hex(32) }
    sequence(:account_key) { |n| SecureRandom.hex(16) }
    metadata { 'male, age 32, unemployed, college-educated' }
  end
end
