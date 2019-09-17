
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
redirect '/articles'
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

  post '/articles/?' do 

    article = Article.create(params)
    
    redirect "/articles/#{article.id}"

  end


  

  get '/articles' do 

  @articles = Article.all

  erb :index
  end

  get '/articles/:id/edit' do 
    id = params[:id]
    @article = Article.find(id)
    
    erb :edit
  end 

  patch '/articles/:id' do

    id = params[:id]
    @article = Article.find(id)
    @article.title = params[:title]
    @article.content = params[:content]

    @article.save

    redirect "/articles/#{@article.id}"

  end

  delete "/articles/:id" do
    # Find and delete the book we need to by using the :id in the URL.
    id = params[:id]
    Article.destroy(id)

    # Redirect to the index page.
    redirect "/articles/"

  end

end
