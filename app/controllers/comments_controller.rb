class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to prototype_path(comment.prototype) # プロトタイプの詳細ページにリダイレクト
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
