class RemoveCategoryIdFromExpenses < ActiveRecord::Migration[7.2]
  def change
    remove_column :expenses, :category_id, :integer
  end
end
