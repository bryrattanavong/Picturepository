FactoryBot.define do
    factory :user do
      name { "Tester" }
      email { "Tester@gmail.com" }
      password { "test" }
      balance { 200.00 }
    end
  end