class CopiesController < ApplicationController

  before_filter :authenticate_user!, except: [:show]

  def index
    @copies = Copy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @copies }
    end
  end

  # GET /copies/1
  # GET /copies/1.json
  def show
    @copy = Copy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @copy }
    end
  end

  # GET /copies/new
  # GET /copies/new.json
  def new
    @copy = Copy.new
    @books = Book.all
    @covers = copy_covers
    @book = Book.find_by_id(params[:book_id])
    @copy.title = @book.title

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @copy }
    end
  end

  # GET /copies/1/edit
  def edit
    @copy = Copy.find(params[:id])
    @books = Book.all
    @covers = copy_covers
    @book = Book.find_by_id(params[:book_id])
  end

  # POST /copies
  # POST /copies.json
  def create
    @copy = Copy.new(params[:copy])

    respond_to do |format|
      if @copy.save
        format.html { redirect_to @copy.book, notice: 'Copy was successfully created.' }
        format.json { render json: @copy, status: :created, location: @copy }
      else
        format.html { render action: "new" }
        format.json { render json: @copy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /copies/1
  # PUT /copies/1.json
  def update
    @copy = Copy.find(params[:id])

    respond_to do |format|
      if @copy.update_attributes(params[:copy])
        format.html { redirect_to @copy.book, notice: 'Copy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @copy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /copies/1
  # DELETE /copies/1.json
  def destroy
    @copy = Copy.find(params[:id])
    @copy.destroy

    respond_to do |format|
      format.html { redirect_to copies_url }
      format.json { head :no_content }
    end
  end

  private

    def copy_covers
      ["Hardcover", "Paperback"]
    end
end
