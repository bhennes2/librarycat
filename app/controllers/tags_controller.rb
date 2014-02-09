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
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

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

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :no_content }
    end
  end
  
  private
  
    def tag_types
      ["Subject", "Category"]
    end
  
end