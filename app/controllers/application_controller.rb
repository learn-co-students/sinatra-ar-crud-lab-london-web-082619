
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    @article = Article.new
    erb :new
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    
    erb :show
  end

  get '/articles/:id/edit' do
    id = params[:id]
    @article = Article.find(id)
    
    erb :edit
  end
  
  post '/articles/?' do
    @article = Article.create(params)
    redirect "/articles/#{@article.id}"
  end

  patch "/articles/:id" do
    id = params[:id]
    @article = Article.find(id)
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save

    redirect "/articles/#{@article.id}"
  end


  delete "/articles/:id" do
    id = params[:id]
    Article.destroy(id)

    redirect "/articles"
  end



  


end
