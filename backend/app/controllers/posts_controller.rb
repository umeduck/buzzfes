class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[ create update destroy]
  # GET /posts
  def index
    posts = Post.where(theme_id: params[:theme_id]).where.not(user_id: current_user&.id)
    my_post = Post.find_by(theme_id: params[:theme_id], user_id: current_user&.id)
    render json: {posts: posts, my_post: my_post}
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    if Post.exists?(theme_id: post_params[:theme_id], user_id: current_user.id)
      render json: { error: 'すでに投稿しています。※1つのお題につき投稿は1つまでとなります。' }, status: :conflict
      return
    end
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.user_id != current_user.id
      render json: { error: '他のユーザーの投稿は編集できません。' }, status: :forbidden
      return
    end
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.permit(:theme_id, :title, :content).merge(user_id: current_user.id)
    end
end
