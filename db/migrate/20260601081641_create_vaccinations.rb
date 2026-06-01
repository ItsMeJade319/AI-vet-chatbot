class CreateVaccinations < ActiveRecord::Migration[8.1]
  def change
    create_table :vaccinations do |t|
      t.string :brand
      t.string :diseases
      t.string :target_species
      t.string :description

      t.timestamps
    end
  end
end
