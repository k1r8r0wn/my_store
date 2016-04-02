FactoryGirl.define do
  factory :user do
    login 'login'
    sequence(:email) { |i| "email#{i}@mail.com" }
    password 'password'
  end
end
