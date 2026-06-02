class AddSpeciesAndAgeToPets < ActiveRecord::Migration[8.1]
  def change
    add_column :pets, :species, :string
    add_column :pets, :age, :integer
  end
end
