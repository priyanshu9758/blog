class CreateArticles < ActiveRecord::Migration[5.2]
  # def create_table(i)
  #   # code here
  # end

  def change
    create_table :articles do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
