get '/post/:id' do
  @post = Post.find(params[:id])
  erb :post
end

post '/post' do
  @posts = Post.paginate(:page => params[:page], :per_page => 5)
  @new_post = Post.new(params[:post])
  puts params[:post]
  tags = params[:tags]
  tags = tags.split(' ')
  if @new_post.save
    tags.each do |tag|
      if Tag.find_by_name(tag)
        puts "hey it made it"
        new_tag = Tag.find_by_name(tag)
      else 
        new_tag = Tag.create :name => tag    
      end
        post = Post.find_by_title(params[:post][:title])
        PostTag.create :tag_id => new_tag.id, :post_id => post.id
    end
    redirect to '/'
  else
    erb :index
  end
end

get '/post/:id/edit' do
  puts params[:id]
  @post = Post.find(params[:id])  
  erb :edit
end

post '/post/:id/edit' do
  @post = Post.find(params[:id])
  @post.update_attributes(params[:post])
  erb :edit
end

post '/post/:id/delete' do
  post = Post.find(params[:id])
  post.post_tags.destroy_all
  post.destroy
  redirect to '/'
end
