300.times do
  Post.create title: Faker::Book.title,
              body:  Faker::StarWars.quote
end

["Sports", "Technology", "Finance", "Hardware", "Software", "Entertainment", "Politic", "Education", "Housing", "Games"].each do |c|
  Category.create title: c
end
