class ArticlesController < ApplicationController

  # GET /articles
  #   =link_to .. articles_path
  def index
    @articles = Article.order created_at: :desc
  end
  # Automatically renders /articles/index (with @articles available)

  # GET /articles/new
  #   =link_to .. new_article_path
  def new
    @article = Article.new
  end
  # Automatically renders /articles/new haml which renders /articles/_form haml
  #   with contains =form_for @article .. with @article.new_record?
  #   which renders /articles/new html which contains
  #   <form action='/articles', method='post'..>
  #     <input name='article[:title]', ..>

  # POST /articles
  #   <form action='/articles' method='post'..>
  #   =form_for @article .. if @article.new_record?
  def create
    @article = Article.new article_params
    if @article.save
      redirect_to @article, notice:'Article created.'
    else
      render :new
    end
  end
  # No view. Explicitly redirect_to|render action|view

  # GET /articles/:id
  #   =link_to .. @article | article_path( @article )
  #   the value of :id is extracted by router and assigned to params[:id]
  def show
    @article = Article.find params[:id]
  end
  # Automatically renders /articles/show (with @article available)

  private
    def article_params
      params.require( :article ).permit( :title, :content )
    end
end
