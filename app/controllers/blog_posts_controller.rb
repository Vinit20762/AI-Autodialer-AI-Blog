class BlogPostsController < ApplicationController
  def index
    @blog_posts = BlogPost.order(created_at: :desc)
  end

  def show
    @blog_post = BlogPost.find(params[:id])
  end

  def new
    @blog_post = BlogPost.new
  end

  # Manual create if you ever want it
  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post, notice: "Blog post created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # AI bulk generation – titles list comes from textarea
  def generate_from_ai
    titles_text = params[:titles_text].to_s

    ai = AiClient.new
    articles = ai.generate_articles(titles_text)

    articles.first(10).each do |art|
      BlogPost.create!(
        title: art["title"],
        body:  art["body"]
      )
    end

    redirect_to blog_posts_path, notice: "#{articles.size} AI articles generated."
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end
end
