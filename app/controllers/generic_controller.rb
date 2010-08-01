class GenericController < ApplicationController

  def show
    @resource = SemanticRecord::Base.new(params[:uri])
  end
  
end