class BooksController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @books = Book.order('sortable_title ASC').page(params[:page]&.to_i || 1)
    @letters = ('A'..'Z').to_a

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id], include: :copies)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new
    @book.copies.build
    @book_types = book_types
    @tags = []

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id], include: [:descriptors])
    @book_types = book_types
    @tags = @book.descriptors.map(&:tag_id)
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])
    @book.subject_ids = params[:subjects]
    @book.category_ids = params[:categories]
    @book.copies.first.title = @book.title

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        @book_types = book_types
        @tags = []
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])
    @book.subject_ids = params[:subjects]
    @book.category_ids = params[:categories]

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private

    def book_types
      ["Fiction", "Nonfiction", "Easy", "Story Collection", "Reference", "Graphic Novel"]
    end
end
