FactoryBot.define do
  factory :pledge do
    user
    dollar_amount 100
    project
  end
end
