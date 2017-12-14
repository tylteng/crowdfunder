FactoryBot.define do
  factory :project do
    title "Bootcamp"
    description "Programming course"
    goal 100
    start_date Time.now
    end_date Time.now + 30.days
    user
  end
end
