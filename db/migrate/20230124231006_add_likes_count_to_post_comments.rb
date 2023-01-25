class AddLikesCountToPostComments < ActiveRecord::Migration[6.1]
  def change
    add_column :post_comments, :likes_count, :integer
  end
end
