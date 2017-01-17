class ArticlesController < ApplicationController

  # GET /articles
  #   from: <a href='/articles'> .. </a>
  #   by:   =link_to .. articles_path
  def index
    @articles = Article.order created_at: :desc
  end
  # Automatically renders /articles/index haml view (with @articles available)
  #   that renders /articles html index page

  # GET /articles/new
  #   from: <a href='/articles/new'> .. </a>
  #   by:   =link_to .. new_article_path
  def new
    @article = Article.new
  end
  # Automatically renders /articles/new haml view
  #   that renders /articles/_form haml partial
  #   that contains =form_for @article .. with @article.new_record?
  #   all of which renders /articles/new html page that contains
  #   <form action='/articles', method='post'..>
  #     <input name='article[:title]', ..>

  # POST /articles
  #   from: <form action='/articles' method='post'..>
  #   by:   =form_for @article .. if @article.new_record?
  def create
    @article = Article.new article_params
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
    @article = Article.find params[:id]
  end
  # Automatically renders /articles/show haml view (with @article :id)
  #   that renders /articles/1 html show page

  # GET /articles/:id/edit
  #   from: <a href='/articles/1/edit'> .. </a>
  #   by:   =link_to .. [:edit, @article] | edit_article_path( @article )
  #   router extracts the value of :id and assigns it to params[:id]
  def edit
    @article = Article.find params[:id]
  end
  # Automatically renders /articles/:id/edit haml view (with @article :id)
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
    @article = Article.find params[:id]

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
    @article = Article.find params[:id]
    @article.destroy
    redirect_to articles_path, notices:'Article deleted.'
  end
  # No view. Explicitly redirect_to some action

  private
    def article_params
      params.require( :article ).permit( :title, :content )
    end
end
