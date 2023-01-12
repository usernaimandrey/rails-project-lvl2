class AddEmailDeliveryEnabledToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email_delivery_enabled, :boolean
  end
end
