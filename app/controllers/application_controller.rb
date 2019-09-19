
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  # NEW ROUTE (shows form to create new instance)
  get '/articles/new' do
    @article = Article.new
    erb :new 
  end
  # so this shows you the form to fill out for a new Article which is then sent on to the below post method


  # CREATE ROUTE (takes info from form filled in as rendered by NEW ROUTE and saves instance to the database)
  post '/articles/?' do
    @article = Article.create(params)
    redirect to "/articles/#{@article.id}"
  end
  # so this creates a new instance of Article using the params hash of user input to the form from
  # get '/articles/new'


  # SHOW ROUTE (info on specific instance)
  get '/articles/:id' do 
    @article = Article.find(params[:id])
    erb :show
  end
  # saves a specific article (found by id, which is taken from params, which in this case takes from the url entered)
  # so that it can be rendered in the show.erb file


  # INDEX ROUTE (info on all instances)
  get '/articles' do
    @articles = Article.all
    erb :index
  end
  # saves all articles to a variable that can be then accessed and rendered by the index.erb file


  # EDIT ROUTE
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end


  # UPDATE ROUTE (patching)
  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.title = (params[:title])
    @article.content = (params[:content])
    @article.save
    redirect to "/articles/#{ @article.id }"
  end

  # DELETE
  delete "/articles/:id" do
    Article.destroy(params[:id])
    redirect "/articles"
  end
end
