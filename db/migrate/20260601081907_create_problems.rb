class CreateProblems < ActiveRecord::Migration[8.1]
  def change
    create_table :problems do |t|
      t.string :description
      t.string :outcome
      t.string :title

      t.timestamps
    end
  end
end
