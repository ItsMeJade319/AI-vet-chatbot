# db/seeds.rb

# Ensure the pet with ID 1 exists so the foreign key constraint doesn't fail
pet = Pet.find_or_create_by!(id: 1) do |p|
  p.name = "Fluffy" # Add any other required attributes for your Pet model here
end

puts "Creating problem seeds for Pet ID 1..."

Problem.create!([
  {
    pet_id: pet.id,
    title: "Excessive Scratching",
    description: "The pet has been scratching its left ear constantly for the past 48 hours, causing minor redness.",
    outcome: "Diagnosed with ear mites; prescribed topical ear drops for 7 days."
  },
  {
    pet_id: pet.id,
    title: "Sudden Lethargy",
    description: "Skipped breakfast and refused to go for the usual morning walk. Seemed to lack energy.",
    outcome: "Monitored for 24 hours. Recovered naturally, likely just an upset stomach."
  },
  {
    pet_id: pet.id,
    title: "Routine Vaccination",
    description: "Scheduled annual rabies and DHPP booster shots.",
    outcome: "Vaccinations administered successfully. Next booster due in 12 months."
  }
])

puts "Successfully created #{Problem.where(pet_id: 1).count} problems for Pet ID 1!"
