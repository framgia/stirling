class Stirling::BaseController < ApplicationController
  before_filter :build_instance, only: [:new, :create]
  before_filter :set_instance, only: [:show, :destroy, :edit, :update]
  before_filter :assign_params, only: [:update]

  def index; end
  def show; end
  def new; end
  def create; end
  def edit; end
  def update; end
  def destroy; end

  private
  def set_instance
    instance = model.find params[:id]
  end

  def build_instance
    instance = model.new model_params
  end

  def instance
    instance_variable_get "@#{model_name}"
  end

  def instance= new_instance
    instance_variable_set "@#{model_name}", new_instance
  end

  def assign_params
    instance.assign_attributes model_params
  end

  def model
    model_name.classify.safe_constantize
  end

  def model_name
    controller_name.singularize
  end

  def model_name_symbol
    model_name.intern
  end

  def model_params
    if Rails.version >= "4.0.0"
      params.fetch(model_name_symbol, {}).permit model.acceptable_attributes
    else
      params[model_name_symbol]
    end
  end
end
