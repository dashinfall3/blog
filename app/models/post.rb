class Post < ActiveRecord::Base
  has_many :post_tags
  has_many :tags, :through => :post_tags

  validates :title, :presence => { :message => ": Make sure you put in that thought provoking title for this blog post." }
  validates :body, :presence => { :message => ": Your blog post content was empty. Add some content to the body of the post." }


end
