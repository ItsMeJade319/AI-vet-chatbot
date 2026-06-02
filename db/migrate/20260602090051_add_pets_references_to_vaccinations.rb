class AddPetsReferencesToVaccinations < ActiveRecord::Migration[8.1]
  def change
    add_reference :vaccinations, :pet, foreign_key: true
  end
end
