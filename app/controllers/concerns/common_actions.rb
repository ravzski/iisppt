module CommonActions
  extend ActiveSupport::Concern

  def basic_create
    if @obj.save
      yield if block_given?
      render_create_success
    else
      render_obj_errors
    end
  end

  def basic_update
    if @obj.update_attributes(obj_param)
      yield if block_given?
      render_update_success
    else
      render_obj_errors
    end
  end

  def basic_destroy
    if @obj.destroy
      yield if block_given?
      render_empty_success
    else
      render_obj_errors
    end
  end

  def basic_show
    render json: @obj
  end

  private

  def collection_paginator(collection)
    if params[:all].present?
      @collection = collection.active.order("name")
    else
      @collection = collection.search(query_params).page(current_page).order("id DESC")
    end
  end


end
