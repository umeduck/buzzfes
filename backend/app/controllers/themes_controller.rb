class ThemesController < ApplicationController
  before_action :set_theme, only: %i[ show update destroy ]

  # GET /themes
  def index
    @themes = Theme.all

    render json: @themes
  end

  # GET /themes/1
  def show
    render json: @theme
  end

  # POST /themes
  def create
    @theme = Theme.new(theme_params)

    if @theme.save
      render json: @theme, status: :created, location: @theme
    else
      render json: @theme.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /themes/1
  def update
    if @theme.update(theme_params)
      render json: @theme
    else
      render json: @theme.errors, status: :unprocessable_entity
    end
  end

  # DELETE /themes/1
  def destroy
    @theme.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def theme_params
      params.require(:theme).permit(:title, :description, :start_at, :end_at)
    end
end
