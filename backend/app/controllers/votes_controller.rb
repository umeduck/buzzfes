class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show destroy ]
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
    # 同じ投稿に対して投票をおこなっていないか
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      render json: { error: 'Post not found' }, status: :not_found
      return
    end

    @vote = Vote.find_by(user_id: current_user.id, theme_id: @post.theme_id)

    if @vote
      @vote.update!(post_id: params[:id])
      render json: { vote_status: 1 }, status: :ok
      return
    else
      Vote.create!(user_id: current_user.id, theme_id: @post.theme_id, post_id: params[:id])
      render json: { vote_status: 1 }, status: :ok
      return
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
end
