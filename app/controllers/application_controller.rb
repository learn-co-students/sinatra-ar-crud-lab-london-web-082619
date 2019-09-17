
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #READ
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  #CREATE
  get '/articles/new' do
    @article = Article.new
    erb :new
  end

  #READ
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  #CREATE
  post '/articles/?' do
    @article = Article.create(params)
    redirect "/articles/#{@article.id}"
  end

  #UPDATE
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  #UPDATE
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save

    redirect "/articles/#{@article.id}"
  end
  

  delete '/articles/:id' do
    Article.destroy(params[:id])
    redirect "/articles"
  end
end
