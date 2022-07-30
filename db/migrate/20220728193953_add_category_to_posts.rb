class AddCategoryToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :category, null: false, foreign_key: { on_delete: :cascade }
  end
end
