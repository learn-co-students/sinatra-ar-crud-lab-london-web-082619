
require_relative '../../config/environment'
require "pry"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  #CREATE
  get '/articles/new' do # enters a form to create a new article
    @article = Article.new #an empty object is used to enter CREATE form instead of EDIT PAGE form
    erb :'new'
  end

  post '/articles/?' do #recieves a POST in params hash
    @article = Article.create(params) #creates a new article instance using params hash, saving the instance into variable to be used in redirecting
    # binding.pry
    redirect "/articles/#{@article.id}" #redirects to the new article created
  end

  # READ
  get '/articles' do 
    @all = Article.all # takes in all the articles that can be rendered in index.erb
    erb :index
  end

  get '/articles/:id' do #Enters the specifc page to read
    @article = Article.find(params[:id]) #uses the ID entered in URL to find the book in database, store in variable thats rendered in show.erb
    erb :show
  end

  # EDIT
  get '/articles/:id/edit' do #Enters an edit page of specific article
    @article = Article.find(params[:id]) #Find the book that needs editing by it's ID entered in the URL
    erb :edit
  end

  #UPDATE
  patch '/articles/:id' do #patches up the article with the specific ID
    @article = Article.find(params[:id]) # Finds the article by its ID 
    @article.title = params[:title]  #since patch params contains the details from Edit page, we can use them to update contents
    @article.content = params[:content]
    @article.save #saves the updated items
    redirect "/articles/#{@article.id}" #redirects to updated/pathced article
  end

  #DELETE

  delete '/articles/:id' do
    Article.destroy(params[:id])
    redirect '/articles'
  end
end
