# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find_by(id: params[:id])
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = t('.success')
      redirect_to admin_categories_path
    else
      flash.now[:alert] = t('.failure')
      render :new
    end
  end

  def update
    @category = Category.find_by(id: params[:id])

    if @category.update(category_params)
      flash[:notice] = t('.success')
      redirect_to admin_categories_path
    else
      flash[:alert] = @category.errors.full_messages.join(' ')
      redirect_to edit_admin_category_path(@category)
    end
  end

  def destroy
    category = Category.find_by(id: params[:id])
    category.destroy

    flash[:notice] = t('.success')
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
