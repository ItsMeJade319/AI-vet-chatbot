// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

document.addEventListener("turbo:load", () => {
  const speciesSelect = document.getElementById("species-select");
  const breedSelect = document.getElementById("breed-select");

  const otherSpeciesField = document.getElementById("other-species-field");
  const otherBreedField = document.getElementById("other-breed-field");

  const breeds = {
    Dog: ["Golden Retriever", "Poodle", "Beagle", "Other"],
    Cat: ["Persian", "Siamese", "British Shorthair", "Other"],
    Rabbit: ["Holland Lop", "Lionhead", "Other"],
    Bird: ["Cockatiel", "Parakeet", "Other"],
    Other: ["Other"]
  };

  // Species change
  speciesSelect.addEventListener("change", () => {
    const species = speciesSelect.value;

    // Show/hide custom species field
    otherSpeciesField.style.display =
      species === "Other" ? "block" : "none";

    // Reset breed dropdown
    breedSelect.innerHTML =
      '<option value="">Select a breed</option>';

    if (breeds[species]) {
      breeds[species].forEach((breed) => {
        const option = document.createElement("option");
        option.value = breed;
        option.textContent = breed;
        breedSelect.appendChild(option);
      });
    }

    // Hide breed custom field when species changes
    otherBreedField.style.display = "none";
  });

  // Breed change
  breedSelect.addEventListener("change", () => {
    otherBreedField.style.display =
      breedSelect.value === "Other" ? "block" : "none";
  });
});
