
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #CREATE
  get '/articles/new' do
    @article = Article.new
    erb :new
  end

  post '/articles/?' do
    @article = Article.create(params)
    redirect "/articles/#{@article.id}"
  end

  #READ

  get '/articles' do
    @articles = Article.all
    erb :index
  end
  
  get '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    erb :show
  end

  #EDIT
  get '/articles/:id/edit' do
    @article = Article.find_by(id: params[:id])
    erb :edit
  end

  #UPDATE
  patch "/articles/:id" do
    @article = Article.find_by(id: params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    redirect "/articles/#{@article.id}"
  end

  #DELETE
  delete "/articles/:id" do
    Article.destroy(params[:id])
    redirect "/articles"
  end


end