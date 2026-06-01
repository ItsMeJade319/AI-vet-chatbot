class Vaccination < ApplicationRecord
  belongs_to :pet

  validates :brand, presence: true
  validates :diseases, presence: true
  validates :target_species, presence: true
end
