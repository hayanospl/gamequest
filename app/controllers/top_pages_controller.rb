class TopPagesController < ApplicationController
  def index
  end

  def new
    @id = params[:id]
  end
end
