class BooksController < ApplicationController

  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if  @book.save
      flash[:notice]="投稿が完了しました"
      redirect_to book_path(@book.id)
    else
      render :new
    end
  end

  def index
    @books=Book.all
  end

  def show
    @book=Book.find(params[:id])
  end

  def edit
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="投稿内容を更新しました"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to '/'
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book=Book.find(params[:id])
    unless book.user.id==current_user.id
      redirect_to books_path
    end
  end

end
