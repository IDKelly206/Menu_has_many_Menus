require 'faker'

puts "-------------------"
puts "seeding Recipes"
puts "-------------------"

recipe = 1

30.times do
  Recipe.create!(
    label: Faker::Book.title,
    source: Faker::Book.author,
    yield: rand(1..8)
  )
  puts "created Reicpe # #{recipe}"
  recipe += 1
end

puts "-------------------"
puts "completed seeding"
puts "-------------------"
