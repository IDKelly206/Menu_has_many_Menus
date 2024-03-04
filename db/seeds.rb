
puts "-------------------"
puts "seeding Health"
puts "-------------------"

health_types = [
  "vegetarian",
  "egg-free",
  "kosher",
  "dairy-free",
  "vegan"
]

health_types.each { |type| Health.create(parameter: type) }

puts "-------------------"
puts "completed seeding"
puts "-------------------"
