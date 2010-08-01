class NamespacesController < ApplicationController
  def show
    
    begin 
      @uri = params[:id].to_s.expand
    rescue
      @uri = "Namespace nicht registriert"
    end
    
    respond_to do |format| 
      format.js
    end      

    
  end
  
end
