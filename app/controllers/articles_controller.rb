class ArticlesController < ApplicationController
   before_action :authenticate_account!, except: [:home]
   before_action :account
  def index
    @q=Article.ransack(params[:q])

    @article = Article.new
    @article.account_id=current_account.id
    if current_account.roles.first.name=="admin"

      @articles = @q.result.order("created_at DESC")
    else

      @articles = Article.where(status: :public).or(Article.where(account: current_account)).order("created_at DESC")

    end

  end

  def show
     @article = Article.find(params[:id])

  end

  def home
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.account_id=current_account.id
    if @article.save!
     redirect_to root_path
    else
      render '/', status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

   def export_articles
     @articles=Article.all
     respond_to do |f|
       f.html
       f.csv {send_data @articles.to_csv_post}
       f.xlsx
       # format.xls { send_data @articles.to_csv_post(col_sep: "\t") }
     end
   end
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      redirect_to root_path
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end

  private
def account
  @accounts=Account.all
end

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end

