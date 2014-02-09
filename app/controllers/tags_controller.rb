class TagsController < ApplicationController
  
  def index
    @tags = Tag.all_capitalized_and_alphabetized
    
    respond_to do |format|
      format.html
      format.json { render json: @tags }
    end
  end

  def show
    @tag = Tag.find(params[:id], include: :books)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag }
    end
  end

  def new
    @tag = Tag.new
    @tag_types = tag_types

    respond_to do |format|
      format.html
    end
  end

  def edit
    @tag = Tag.find(params[:id])
    @tag_types = tag_types
  end

  def create
    @book = Book.new(params[:book])
    
    @book.tags = Tag.find_or_create_by_names(names: params[:subjects], tag_type: Tag.subject_type)
    @book.tags.concat(Tag.find_or_create_by_names(names: params[:categories], tag_type: Tag.category_type))

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @tag = Tag.find(params[:id])
    
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end
  
  private
  
    def tag_types
      ["Subject", "Category"]
    end
  
end