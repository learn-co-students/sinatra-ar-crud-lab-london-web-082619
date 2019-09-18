
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #CREATE GET
  get '/articles/new' do 
    @article = Article.new
    erb :new
  end

  
  #Read id get
  get "/articles/:id" do 
    @article = Article.find(params[:id]) 
    erb :show 
  end 

  #CREATE POST
  post '/articles/?' do 
    article = Article.create(params)
    redirect "/articles/#{article.id}"
  end

  #READ get 
  get '/articles' do 
    @articles = Article.all 
    erb :index
  end

  #EDIT 
  get '/articles/:id/edit' do 
    @article = Article.find(params[:id])
    erb :edit
  end

  #UPDATE 
  patch "/articles/:id" do 
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]  #at this top you just changed it without saving
    @article.save                          #saves and updates
    
    redirect "/articles/#{@article.id}"
  end 

  #DELETE
  delete "/articles/:id" do 
  Article.destroy(params[:id])
  redirect "/articles"
  end



  end

