class PrototypesController < ApplicationController
  before_action :authenticate_user!,except: [:index, :show]
  before_action :move_to_index, except: [:index, :show, :new, :create]

  


  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create

    def create
      @prototype = Prototype.new(prototype_params)
      if @prototype.save
        redirect_to root_path, notice: 'プロトタイプを投稿しました！'
      else
        # saveが失敗した場合、投稿ページを再表示
        render :new, status: :unprocessable_entity
      end
    end
  end

  def show
    @comment = Comment.new
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])

  end

  def update
    @prototype = Prototype.find(params[:id]) 

    if @prototype.update(prototype_params) 
      redirect_to prototype_path(@prototype), notice: 'プロトタイプが更新されました！'
    else 
      render :edit, alert: 'プロトタイプの更新に失敗しました。'
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def move_to_index
    prototype = Prototype.find(params[:id])
    # ログイン中のユーザーが投稿者でない場合トップページにリダイレクト
    redirect_to root_path unless prototype.user == current_user
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end

