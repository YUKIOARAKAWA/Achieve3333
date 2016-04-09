# == Schema Information
#
# Table name: blogs
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BlogsController < ApplicationController

  #ログインしていない場合を制限する
  before_action :authenticate_user!, only: :index

  def index
    @blogs = Blog.all
    @blog = current_user.blogs.build
  end

  def create
    @blog = current_user.blogs.build(blogs_params)
    if @blog.save
      flash[:success] = "投稿完了"
      redirect_to blogs_path
    else
      @blogs = Blog.all
      flash[:danger] = "入力してください"
      render 'index'
    end
  end

  def edit
    @blog = Blog.find(params[:id])
    @blogs = Blog.all
    render 'index'
  end

  def update
    @blog = Blog.find(params[:id])
      if current_user.id != @blog.user.id
        flash[:danger] = "不正な操作が検出されました"
        redirect_to blogs_path
      elsif @blog.update(blogs_params)
        flash[:success] = "更新完了"
        redirect_to blogs_path
      else
        flash[:danger] = "入力してください"
        @blogs = Blog.all
        render "index"
      end
  end

  def destroy

  end

  private
  def blogs_params
    params.require(:blog).permit(:content)
  end

end
