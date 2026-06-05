class AddMonthAndYearsToPets < ActiveRecord::Migration[8.1]
  def change
    add_column :pets, :age_years, :integer
    add_column :pets, :age_months, :integer
    change_column :pets, :weight, :decimal
    remove_column :pets, :age, :integer
  end
end
