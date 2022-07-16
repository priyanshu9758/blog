class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :account, null: false ,  foreign_key: true
      t.references :article, null: false , foreign_key: true

      t.timestamps
    end
    add_index :likes, [:account_id, :article_id], unique: true
  end
end
