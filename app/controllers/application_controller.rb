require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/posts/new' do
    erb :'new'
  end

  get '/posts' do
    @all_posts = Post.all
    erb :index
  end


  get '/posts/:id' do
    #binding.pry
    @post_id = params[:id].to_i
    @post = Post.find(@post_id)
    erb :'show'
  end

  get '/posts/:id/edit' do
    @post = Post.find_by_id(params[:id])
    erb :edit
    #binding.pry
    #redirect to('/posts/@post_id')
  end


  patch '/posts/:id' do  #updates a post
    @post = Post.find_by_id(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    erb :show
  end

   post '/posts' do  #creates a post
     @nothin = Post.create(name: params[:name], content: params[:content])
     redirect to '/posts'
     #binding.pry
     #form in 'new' leads here with params
     #create the blog post and save it to the database
     #Post.create(some_attribute: params[:some_attribute])
   end

  delete '/posts/:id/delete' do
    @post = Post.find_by_id(params[:id])
    @da_post = @post.name
    @post.delete
    erb :delete
    #redirect to('/posts')
  end



end
