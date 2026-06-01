class Pet < ApplicationRecord
  has_many :problems
  validates :name, presence: true
  validates :breed, presence: true
  validates :weight, presence: true
end
