class ArticlesController < ApplicationController
	before_action :set_article, only: [ :show, :edit, :destroy, :update]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

def show
end

def index
	@articles = Article.paginate(page: params[:page], per_page: 5)

end

def new
	@article = Article.new
end

def edit
end

def create
  @article = Article.new(article_params)
  @article.user = current_user
	if @article.save
		flash[:notice] = "Article was created successfully"
		redirect_to article_path(@article)
	else
		render 'new'
	end
end

def update
	if @article.update(article_params)
		flash[ :notice ] = "Article was updated successfully!"
		redirect_to @article
	else
		render 'edit'
	end
end

def destroy
	@article.destroy
	redirect_to articles_path
end

private

def set_article
	@article = Article.find(params[:id])
end

def article_params
	params.require(:article).permit(:title, :description)
end

def require_same_user
  if current_user != @article.user && !current_user.admin?
    flash[:alert] = "You can only edit or delete your own article"
    redirect_to @article
  end
end

=begin
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
 # def index
  #  @articles = Article.all
  #end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :description)
    end
=end
end
