FactoryBot.define do
  factory :user do
    name {'User'}
    mail { 'user@email.com' }
    password { 'secret1234' }
  end
end
