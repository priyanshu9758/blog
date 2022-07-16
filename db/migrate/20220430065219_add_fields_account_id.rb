class AddFieldsAccountId < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :account_id, :integer
    add_column :comments, :account_id, :integer
    rename_column :likes, :accounts_id, :account_id
    rename_column :likes, :articles_id, :article_id
  end
end
