class Account < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:lockable
  after_create :assign_default_role
  has_many :articles, dependent: :destroy
  has_many :comments, through: :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  VALID_NUMBER_REGEX=/\A^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[789]\d{9}$\z/i
  validates :Phone_number, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 10 ,maximum: 10 },
            format: { with: VALID_NUMBER_REGEX }

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end


  def self.import(row)
    accessible_attr = %w[first_name last_name email Phone_number password password_confirmation]
    acc = new
    acc.attributes =  row.slice(*accessible_attr)
    acc.save!
  end


  def self.to_csv(options = {})
    CSV.generate(options, headers:true) do |csv|
      headers = ['Name', 'Posts', "Comments", "likes"]
      CSV.generate_line headers
      csv << headers
      all.each do |acc|
        csv << [name="#{acc['first_name']} #{acc["last_name"]}",acc.articles.length,acc.comments.length,acc.likes.length]
      end
    end
  end

  def self.to_csv_limited(options = {})
    CSV.generate(options, headers:true) do |csv|
      headers = ['Name', 'Posts', "Comments", "likes"]
      CSV.generate_line headers
      csv << headers
      all.each do |acc|
        if acc.articles.length>=10
          csv << [name="#{acc['first_name']} #{acc["last_name"]}",acc.articles.length,acc.comments.length,acc.likes.length]
        end
      end
    end
  end

   end
