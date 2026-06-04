# # db/seeds.rb

# # Ensure the pet with ID 1 exists so the foreign key constraint doesn't fail
# pet = Pet.find_or_create_by!(id: 1) do |p|
#   p.name = "Fluffy" # Add any other required attributes for your Pet model here
# end

# puts "Creating problem seeds for Pet ID 1..."

# Problem.create!([
#   {
#     pet_id: pet.id,
#     title: "Excessive Scratching",
#     description: "The pet has been scratching its left ear constantly for the past 48 hours, causing minor redness.",
#     outcome: "Diagnosed with ear mites; prescribed topical ear drops for 7 days."
#   },
#   {
#     pet_id: pet.id,
#     title: "Sudden Lethargy",
#     description: "Skipped breakfast and refused to go for the usual morning walk. Seemed to lack energy.",
#     outcome: "Monitored for 24 hours. Recovered naturally, likely just an upset stomach."
#   },
#   {
#     pet_id: pet.id,
#     title: "Routine Vaccination",
#     description: "Scheduled annual rabies and DHPP booster shots.",
#     outcome: "Vaccinations administered successfully. Next booster due in 12 months."
#   }
# ])

# puts "Successfully created #{Problem.where(pet_id: 1).count} problems for Pet ID 1!"

# db/seeds.rb

puts "Seeding vaccinations for Pet ID: 1..."

vaccinations_data = [
  {
    pet_id: 1,
    brand: "Nobivac Canine 1-DAPPv",
    description: "Core vaccine protecting against major canine viruses. Administered via subcutaneous injection.",
    diseases: "Canine Distemper, Adenovirus Type 2, Parvovirus, Parainfluenza",
    target_species: "Dog",
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    pet_id: 1,
    brand: "Defensor 3",
    description: "Annual Rabies vaccination required by local regulations.",
    diseases: "Rabies",
    target_species: "Dog",
    created_at: 1.year.ago,
    updated_at: 1.year.ago
  },
  {
    pet_id: 1,
    brand: "Bronchicine CAE",
    description: "Non-core lifestyle vaccine recommended for dogs frequently visiting boarding or daycare facilities.",
    diseases: "Bordetella bronchiseptica (Kennel Cough)",
    target_species: "Dog",
    created_at: 6.months.ago,
    updated_at: 6.months.ago
  }
]

# Using insert_all skips model validations/callbacks but is highly efficient,
# or you can loop through using Vaccination.create!(attrs) if you have the model defined.
Vaccination.insert_all!(vaccinations_data)

puts "Successfully seeded #{vaccinations_data.count} vaccinations for Pet ID: 1!"
