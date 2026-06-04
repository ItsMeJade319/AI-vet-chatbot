class AddProblemReferenceToMessages < ActiveRecord::Migration[8.1]
  def change
    add_reference :messages, :problem, null: false, foreign_key: true
  end
end
