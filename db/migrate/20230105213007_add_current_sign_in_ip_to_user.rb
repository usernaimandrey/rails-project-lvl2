class AddCurrentSignInIpToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :current_sign_in_ip, :string
  end
end
