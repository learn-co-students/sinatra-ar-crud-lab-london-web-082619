
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :"index"
  end

  post '/articles/?' do
    article = Article.create(params)
    redirect "/articles/#{article.id}"
  end

  get '/articles/new' do
    @article = Article.new
    erb :"new"
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :"show"
  end

  get '/articles/:id/edit' do
    id = params[:id]
    @article = Article.find(id)
    erb :"edit"
  end

  patch '/articles/:id' do
    # will find the instance of the model to update, using the id from params, update and save that instance.
    id = params[:id]
    @article = Article.find(id)
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    id = params[:id]
    Article.destroy(id)
    redirect "/articles"
  end

end
