
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/articles" do
    @articles = Article.all
    erb :index
  end

  get "/articles/new" do
    @article = Article.new
    erb :new
  end

  post "/articles/?" do
    @article = Article.find_or_create_by(title: params[:title], content: params[:content])
    redirect "/articles/#{@article.id}"
  end

  get "/articles/:id" do
    @article = Article.find_by(id: params[:id])
    erb :show
  end

  patch "/articles/:id" do
    article = Article.find_by(id: params[:id])
    binding.pry
    article.update(params.reject { |k, v| k == "_method" || k == "Submit" })
    redirect "/articles/#{article.id}"
  end

  get "/articles/:id/edit" do
    @article = Article.find_by(id: params[:id])
    erb :edit
  end

  delete "/articles/:id/delete" do
    Article.destroy(params[:id])
    redirect "/articles"
  end


end
