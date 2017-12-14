FactoryBot.define do
  factory :user do
    first_name "Ty"
    last_name "Dollar"
    sequence(:email) {|x| "tydollar#{x}@bitmaker.com"}
    admin false
    password "password"
    password_confirmation "password"
  end
end
