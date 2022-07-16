class AddBanAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :hidden, :boolean, default:false
  end
end
