class Article < ApplicationRecord
  belongs_to :account
  has_many :comments, dependent: :destroy
  has_many :likes,dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  VALID_STATUSES = ['public', 'private']

  validates :status, inclusion: { in: VALID_STATUSES }

  def archived?
    status == 'archived'
  end
  def self.to_csv_post(options = {})
    CSV.generate(options, headers:true) do |csv|
      headers = ['description','posts', "Comments", "likes"]
      CSV.generate_line headers
      csv << headers
      all.each do |acc|
        csv << [name=" #{acc["body"]}",acc.comments.length,acc.likes.length]
      end
    end
  end

  end