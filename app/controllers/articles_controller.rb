class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @articles = Article.all
  end
  
  def show
    @comments = @article.comments
    @comment = @article.comments.build
  end
  
  def edit
    unless @article.user == current_user
      flash[:alert] = "You can only edit your own article"
      redirect_to root_path
    end
  end
  
  def update
    unless @article.user == current_user
      flash[:danger] = "You can only edit your own article"
      redirect_to root_path
    else
      if @article.update(article_params)
        flash[:success] = "Article has been updated"
        redirect_to @article
      else
        flash.now[:danger] = "Article has not been updated"
        render 'edit'
      end
    end
  end
  
  def destroy
    unless @article.user == current_user
      flash[:danger] = "You need to sign in or sign up to continue."
      redirect_to articles_path
    else
      if @article.destroy
        flash[:success] = "Article deleted successfully."
        redirect_to articles_path
      else
        flash.now[:danger] = "You can't delete an article you don't own."
        redirect_to articles_path
      end
    end
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    
    if  @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created"
      render 'new'
    end
  end
  
  protected
  
    def resource_not_found
      message = "The article you are looking for could not be found"
      flash[:alert] = message
      redirect_to root_path
    end
  
  private
  
    def article_params
      params.require(:article).permit(:title, :body)
    end
    
    def find_article
      @article = Article.find(params[:id])
    end
  
end
