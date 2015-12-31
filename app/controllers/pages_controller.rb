class PagesController < ApplicationController

  def home

  end

  def search
    if params[:query].present?
      @books = Book.search(query: params[:query], filter: params[:filter]).page(params[:page] || 1)
    else
      @books = Book.order('sortable_title ASC').page(params[:page] || 1)
    end

  end

end
