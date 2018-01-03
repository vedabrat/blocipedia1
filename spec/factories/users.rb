FactoryBot.define do
  factory :user do
    name "#{random_word} #{random_word}"
    sequence(:email){|n| "user#{n}@factory.com" }
    password pw
    password_confirmation pw
    role :member
    confirmed_at Date.today

 
  end
end
