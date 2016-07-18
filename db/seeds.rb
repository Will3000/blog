300.times do
  Post.create title: Faker::Book.title,
              body:  Faker::Lorem.paragraph
end

["Sports", "Technology", "Finance", "Entertainment", "Politic", "Education"].each do |c|
  Category.create title: c
end

30.times { Tag.create(name: Faker::Hacker.adjective)}
