
puts "-------------------"
puts "seeding Health"
puts "-------------------"

health_types = [
  "dairy-free",
  "egg-free",
  "kosher",
  "vegan",
  "vegetarian"
]

health_types.each { |type| Health.create(parameter: type)}

puts "-------------------"
puts "completed seeding"
puts "-------------------"
