class CategoriesController < ApplicationController

  before_action :find_user

  def create
    @category = Category.new category_params
    @category.user = @current_user
    unless @category.save
      @messages = @category.errors.full_messages
      render status: :conflict, template: 'layouts/errors'
    end
  end

  def index
    @categories = @current_user.categories
  end

  def destroy
    @category = Category.find(params[:id])
    unless @category
      @messages = ['CategoryNotFound']
      render status: :conflict, template: 'layouts/errors'
    end
    @category.destroy
  end

  private
  def category_params
    params.permit(:title)
  end
end
