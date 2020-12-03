FactoryBot.define do
  factory :user do
    name { "Arthur" }
    email { "user@mail.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
