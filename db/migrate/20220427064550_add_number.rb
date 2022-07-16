class AddNumber < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :Phone_number, :integer
  end
end
