class PredicatesController < ApplicationController
  def show
    @predicate = SemanticRecord::Base.new(params[:uri])   
    respond_to do |format| 
      format.html
      format.js { @attributes = @predicate.attribute(params[:predicate]) }
    end      
  end
  
  def edit
    @predicate = SemanticRecord::Base.new( params[:uri] )   
  end
  
  def update
    @predicate = SemanticRecord::Base.new( params[:predicate].delete(:uri) )
    
    params[:predicate].each do |param,value|
      @predicate.send("#{param}=",value) unless value.blank?
    end
    
    @predicate.save

    redirect_to :action => "show", :controller => "predicates", :uri => @predicate.uri
  
  end
  
end