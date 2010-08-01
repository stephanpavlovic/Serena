class CoresController < ApplicationController
  def recommendations_by_users
    user = User.new("http://www.serena.com/similar.owl##{params[:user]}")
    params[:type] ? result_type = params[:type].downcase : result_type = "xml"
    @products = Core.recommendations_by_users(user)
    case result_type
      when "xml"
        render :xml => @products
      when "json"
        render :json => @products
      else
        raise "Unknown Resulttype, use Xml or Json"
    end
  end
  
  def recommendations_by_user
    user = User.new("http://www.serena.com/similar.owl##{params[:user]}")
    params[:type] ? result_type = params[:type].downcase : result_type = "xml"
    @products = Core.recommendations_by_user(user)
    case result_type
      when "xml"
        render :xml => @products
      when "json"
        render :json => @products
      else
        raise "Unknown Resulttype, use Xml or Json"
    end
  end
  
  def recommendations_by_products
    user = User.new("http://www.serena.com/similar.owl##{params[:user]}")
    products = params[:products].split(',').collect! {|n| "http://knowledge.erco.com/products##{n}"}
    params[:type] ? result_type = params[:type].downcase : result_type = "xml"
    @products = Core.recommendations_by_products(products)
    case result_type
      when "xml"
        render :xml => @products
      when "json"
        render :json => @products
      else
        raise "Unknown Resulttype, use Xml or Json"
    end
  end
end