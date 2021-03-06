class ArticlesController < ApplicationController
  before_action :set_article, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /articles
  #   from: <a href='/articles'> .. </a>
  #   by:   =link_to .. articles_path
  def index
    @articles = if params[:category]
      Article.includes( :category ).where( categories: { name: params[:category] } ).order( created_at: :desc )
    else
      Article.order( created_at: :desc )
    end
  end
  # Implicitly renders /articles/index haml view (with @articles available)
  #   that renders /articles html index page

  # GET /articles/new
  #   from: <a href='/articles/new'> .. </a>
  #   by:   =link_to .. new_article_path
  def new
    @article = current_user.articles.new
  end
  # Implicitly renders /articles/new haml view
  #   that renders /articles/_form haml partial
  #   that contains =form_for @article .. with @article.new_record?
  #   all of which renders /articles/new html page that contains
  #   <form action='/articles', method='post'..>
  #     <input name='article[:title]', ..>

  # POST /articles
  #   from: <form action='/articles' method='post'..>
  #   by:   =form_for @article .. if @article.new_record?
  def create
    @article = current_user.articles.new article_params
    if @article.save
      redirect_to @article, notice:'Article created.'
    else
      render 'new'
    end
  end
  # No view. Explicitly redirect_to|render action|view

  # GET /articles/:id
  #   from: <a href='/articles/1'> .. </a>
  #   by:   =link_to .. @article | article_path( @article )
  #   the value of :id is extracted by router and assigned to params[:id]
  def show
  end
  # Implicitly renders /articles/show haml view (with @article :id)
  #   that renders /articles/1 html show page

  # GET /articles/:id/edit
  #   from: <a href='/articles/1/edit'> .. </a>
  #   by:   =link_to .. [:edit, @article] | edit_article_path( @article )
  #   router extracts the value of :id and assigns it to params[:id]
  def edit
  end
  # Implicitly renders /articles/:id/edit haml view (with @article :id)
  #   that renders /articles/_form haml partial
  #   that contains =form_for @article .. with @article.persisted?
  #   all of which renders /articles/1/edit html page that contains
  #   <form action='/articles/1', method='patch' ..>
  #     <input name='article[title]', ..>

  # PATCH|PUT /articles/:id
  #   from: <form action='/articles/1', method='patch' ..>
  #   by:   =form_for @article .. if @article.persisted?
  #   router extracts :id value from the request and assigns it to params[:id]
  def update
    if @article.update article_params
      redirect_to @article, notice:'Article updated.'
    else
      render 'edit'
    end
  end
  # No view. Explicitly redirect_to|render action|view

  # DELETE /articles/:id
  #   from: <a href='/articles/1', method='delete'> .. </a>
  #   by:   =link_to .. @article, method: :delete
  #   router reads :id value from the request and assigns it to params[:id]
  def destroy
    @article.destroy
    redirect_to articles_path, notices:'Article deleted.'
  end
  # No view. Explicitly redirect_to some action

  private
    def article_params
      params.require( :article ).permit( :title, :content, :category_id )
    end

    def set_article
      @article = Article.find params[:id]
    end
end
