class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :failed_attempts, :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
    add_column :accounts, :locked_at, :datetime

    # Add these only if unlock strategy is :email or :both
    add_column :accounts, :unlock_token, :string
    add_index :accounts, :unlock_token, unique: true
  end
end
