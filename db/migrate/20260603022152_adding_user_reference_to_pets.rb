class AddingUserReferenceToPets < ActiveRecord::Migration[8.1]
  def change
    add_reference :pets, :user, null: false, foreign_key: true
  end
end
