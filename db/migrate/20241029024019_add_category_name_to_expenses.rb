class AddCategoryNameToExpenses < ActiveRecord::Migration[7.2]
  def change
    add_column :expenses, :category_name, :string
  end
end
