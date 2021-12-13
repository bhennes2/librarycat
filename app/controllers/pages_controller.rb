class PagesController < ApplicationController

  def home

  end

  def search
    if params[:query].present?
      @books = Book.search(query: params[:query], filter: params[:filter]).page(page_params || 1)
    else
      @books = Book.order('sortable_title ASC').page(page_params || 1)
    end
  end

  def letter_search
    @books = Book.where('lower(substring(sortable_title from 1 for 1)) = ?', params[:query].downcase)
      .order('sortable_title ASC').page(page_params || 1)

    render :search
  end

  private
  
  def page_params
    params[:page]&.to_i
  end

end
