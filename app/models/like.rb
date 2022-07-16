class Like < ApplicationRecord
  validates :account_id, uniqueness: { scope: :article_id}

  belongs_to :account
  belongs_to :article,dependent: :destroy
end
