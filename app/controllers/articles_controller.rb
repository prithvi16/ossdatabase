class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update]
  before_action, :authenticate_user!, except: [:index, :show]
  before_action :ensure_user_admin , except: [:index, :show]

  def index
    @articles = Article.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article was successfully updated."
    else
      render :edit
    end
  end

  private

  def set_article
    @article = Article.frinedly.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def ensure_user_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
