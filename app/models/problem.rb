class Problem < ApplicationRecord
  belongs_to :pet
  has_many :messages
end
