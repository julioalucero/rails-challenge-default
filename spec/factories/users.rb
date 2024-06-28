# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { 'user@example.com' }
    phone_number { '5551235555' }
    full_name { 'Joe Smith' }
    password { 'password' }
    key { '72ae25495a7981c40622d49f9a52e4f1565c90f048f59027bd9c8c8900d5c3d8' }
    account_key { 'b97df97988a3832f009e2f18663ac932' }
    metadata { 'male, age 32, unemployed, college-educated' }
  end
end
