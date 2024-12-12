class Admin::ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy in_review approve reject ]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
    @article.build_content
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to admin_articles_path, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to admin_articles_path, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to admin_articles_path, status: :see_other, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def in_review
    @content = @article.content
    @content.submit_for_review!
    ContentMailer.with(content: @article.content).notify_content_submitted.deliver_later
    respond_to do |format|
      format.html { redirect_to admin_articles_path, status: :see_other, notice: "Article was successfully changed state to in review." }
      format.json { head :no_content }
    end
  end

  def approve
    @content = @article.content
    @content.approve!
    respond_to do |format|
      format.html { redirect_to admin_articles_path, status: :see_other, notice: "Article was successfully changed state to in published." }
      format.json { head :no_content }
    end
  end
  def reject
    @content = @article.content
    @content.reject!
    respond_to do |format|
      format.html { redirect_to admin_articles_path, status: :see_other, notice: "Article was successfully changed state to in draft." }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:cover, content_attributes: [ :title, :description ])
    end
end
