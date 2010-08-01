class Core < ActiveRecord::Base
  def self.recommendations_by_users(user)
    users = Similar.similar_users(user,3)
    products = Similar.products_by_users(users)
  end
  
  def self.recommendations_by_user(user)
    users = [{user.uri => 1.0}]
    raise users.inspect
    products = Similar.products_by_users(users)
  end
  
  def self.recommendations_by_products(products)
    cats = Product.categories_by_products(products)
    products = Product.products_by_categories(cats)
  end
  
  def self.generate_classification_ratings
    users = User.find
    users.each do |user|
      User.calculate_classification_ratings(user)
    end
  end
  
  def self.interaction_with_product(user,interaction,product)
    #ProductRating
    rating = (SemanticRecord::Base.literal_by_sparql("SELECT DISTINCT ?result WHERE {<#{interaction}> <http://www.serena.com/similar.owl#hasWeight> ?result}")).to_i
    pro = ProductRating.new("http://www.serena.com/similar.owl#ProductRating_#{user.humanize}_#{product.humanize}")        
    if pro.new_record?
      rat = rating
      pro.similar_doneByUser=user
      pro.similar_belongsToProduct=product
    else
      rat = pro.similar_hasRating.first.convert_from_xsd + rating
    end
    pro.similar_hasRating=rat.to_literal("integer") if rat   
    pro.save
    #Overall Rating
    p = Product.new(product)
    if p.similar_hasOverallRating.empty?
       p.similar_hasOverallRating=rating.to_literal("integer") 
    else  
      p.similar_hasOverallRating=(p.similar_hasOverallRating.first.convert_from_xsd + rating).to_literal("integer")
    end  
    p.save
  end
  
  def test
    p = Product.find[0,5]
  end
end