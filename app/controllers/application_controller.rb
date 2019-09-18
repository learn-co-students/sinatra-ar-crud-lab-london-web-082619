
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
    id = params[:id]
    @article = Article.find(id)
    erb :show
  end
  
  # Createss
  post '/articles/?' do
    @article = Article.create(params)
    redirect "/articles/#{@article.id}"
  end

  # Edit for user to input
  get '/articles/:id/edit' do
    id = params[:id]
    @article = Article.find(id)
    erb :edit
  end

  # Update for app to receive and store paied with Edit
  patch "/articles/:id" do
    id = params[:id]
    # require 'pry'
    # binding.pry
    @article = Article.find(id)
    @article.title = params[:title]
    @article.content = params[:content]
    
    @article.save
    
    redirect "/articles/#{@article.id}"
  end

   # Destroy
    delete "/articles/:id" do
    # Find and delete the book we need to by using the :id in the URL.
    id = params[:id]
    Article.destroy(id)

    # Redirect to the index page.
    redirect "/articles"
  end

end
