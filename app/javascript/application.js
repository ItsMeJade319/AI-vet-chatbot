// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

document.addEventListener("turbo:load", () => {
  const speciesSelect = document.getElementById("species-select");
  const breedSelect = document.getElementById("breed-select");

  if (!speciesSelect || !breedSelect) return;

  const breeds = {
    Dog: [
      "Golden Retriever",
      "Poodle",
      "Beagle",
      "Labrador",
      "Other"
    ],
    Cat: [
      "Persian",
      "Siamese",
      "Maine Coon",
      "British Shorthair",
      "Other"
    ],
    Rabbit: [
      "Holland Lop",
      "Netherland Dwarf",
      "Lionhead",
      "Other"
    ],
    Bird: [
      "Parakeet",
      "Cockatiel",
      "Lovebird",
      "Other"
    ],
    Other: ["Other"]
  };

  speciesSelect.addEventListener("change", () => {
    const selectedSpecies = speciesSelect.value;

    breedSelect.innerHTML =
      '<option value="">Select a breed</option>';

    if (breeds[selectedSpecies]) {
      breeds[selectedSpecies].forEach((breed) => {
        const option = document.createElement("option");
        option.value = breed;
        option.textContent = breed;
        breedSelect.appendChild(option);
      });
    }
  });
});
