class LikesController < ApplicationController
  def create
    @like= current_account.likes.new(like_params)
    if !@like.save
      # flash[:notice]=@like.errors.full_messages.to_sentences
      redirect_to "/"
    else
      redirect_to "/"
    end


  end
  def destroy
    @like = current_account.likes.find(params[:id])
    article=@like.article
    @like.destroy
    redirect_to article
  end
  private
  def like_params
    params.require(:like).permit(:article_id)
  end
end
