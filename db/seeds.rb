Pledge.destroy_all
Reward.destroy_all
User.destroy_all
Project.destroy_all
Category.destroy_all

Category.create!(name: "Music")
Category.create!(name: "Art")
Category.create!(name: "Film")
Category.create!(name: "Health")
Category.create!(name: "Tech")


10.times do
  project = Project.new(
              title: Faker::App.name,
              description: Faker::Lorem.paragraph,
              goal: rand(100000),
              start_date: Time.now.utc - rand(60).days,
              end_date: Time.now.utc + rand(10).days
            )
  project.save!(validate: false)
  5.times do
    project.rewards.new(
      description: Faker::Superhero.power,
      dollar_amount: rand(100),
    )
    .save(validate: false)
  end
end

5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    password: 'password',
    password_confirmation: 'password'
  )
end

20.times do
  project = Project.all.sample

  Pledge.create!(
    user: User.all.sample,
    project: project,
    dollar_amount: project.rewards.sample.dollar_amount + rand(10)
  )





end
