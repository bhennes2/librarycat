class TagsController < ApplicationController
  
  def index
    @tags = Tag.all_capitalized
    
    respond_to do |format|
      format.json { render json: @tags }
    end
  end
  
end