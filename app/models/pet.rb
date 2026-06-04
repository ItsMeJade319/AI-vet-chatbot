class Pet < ApplicationRecord
  belongs_to :user
  has_many :problems
  has_many :vaccinations
  validates :name, presence: true
  validates :breed, presence: true
  validates :weight, presence: true
  validates :species, presence: true
  validates :age, presence: true
end
