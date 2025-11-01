class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[ show update destroy ]

  # GET /votes
  def index
    @votes = Vote.all

    render json: @votes
  end

  # GET /votes/1
  def show
    render json: @vote
  end

  # POST /votes
  def create
    if @vote.save
      render json: @vote, status: :created, location: @vote
    else
      render json: @vote.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /votes/1
  def update
    AppLogger.info('fghasdujfi')
    # 同じ投稿に対して投票をおこなっていないか
    @post = Post.find(post_params[:postId])
    # 同じ投稿に投票があった場合は更新(フロントであるかどうかを確認してユーザーに確認画面を表示させる)
    # 同じ投稿に投票がない場合は新規登録
    @vote = Vote.find_by(user_id: current_user.id, post_id: post_params[:postId])
    if @vote
      puts "ユーザーが見つかりました: #{user.name}"
      if @vote.update(vote_params)
        render json: @vote
      else
        render json: @vote.errors, status: :unprocessable_entity
      end
    else
      puts "ユーザーが見つかりませんでした"
      @vote = Vote.new(vote_params)
    end
  end

  # DELETE /votes/1
  def destroy
    @vote.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params.require(:vote).permit(:user_id, :post_id)
    end
end
