
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :'index'
  end
  # new
  get '/articles/new' do
    @article = Article.new
  erb :'new'
end
  # create
  post '/articles/?' do
    article = Article.create(params)
    redirect "/articles/#{article.id}"
  end
  get '/articles/:id' do
    @article = Article.find(params[:id])
    # binding.pry
    erb :'show'
  end
  # edit
  get '/articles/:id/edit'do
  # find the article before editing
  @article = Article.find(params[:id])
  erb :'edit'
end
  patch "/articles/:id" do
  @article = Article.find(params[:id])
  @article.title = params[:title]
  @article.content = params[:content]
  @article.save

  redirect "/articles/#{@article.id}"
end
# Destroy
  delete '/articles/:id' do
    Article.destroy(params[:id])
    
    redirect '/articles'
  end

end

