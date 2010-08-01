class User < SemanticRecord::Base  

  self.base = "http://www.serena.com/user.owl#"
  self.uri="http://www.serena.com/user.owl#User"  
  
  def self.calculate_classification_ratings(user)
    ratings = ProductRating.find_by_similar_doneByUser(user.uri)
    ratings.each do |rating|
      product = rating.similar_belongsToProduct.first
      query = "SELECT DISTINCT ?result WHERE{<#{product.uri}> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?result. ?result <http://www.w3.org/2000/01/rdf-schema#subClassOf> <http://www.serena.com/classification.owl#Concept>.}"
      classifications =  SemanticRecord::Base.find_by_sparql(query)
      classifications.each do |classification|
        cla = ClassificationRating.new("http://www.serena.com/similar.owl#ClassificationRating_#{user.uri.humanize}_#{classification.uri.humanize}")        
        if cla.new_record?
          rat = rating.similar_hasRating.first.convert_from_xsd
          cla.similar_doneByUser=user.uri
          cla.similar_belongsToConcept=classification.uri
        else
          rat = cla.similar_hasRating.first.convert_from_xsd + rating.similar_hasRating.first.convert_from_xsd if cla.similar_hasRating
        end
        cla.similar_hasRating=rat.to_literal("integer") if rat   
        cla.save
      end
    end
  end
  
  def self.calculate_interest_vector(user)
    vector={}
    ratings = ClassificationRating.find_by_similar_doneByUser(user.uri)
    max=0
    ratings.each do |rating|
      rat= rating.similar_hasRating.first.convert_from_xsd
      max = rat if rat > max
      vector[rating.similar_belongsToConcept.first.uri.humanize]=rat
    end
    @@concepts.each do |concept|
      vector[concept.uri.humanize] ? vector[concept.uri.humanize] = vector[concept.uri.humanize].to_f/max : vector[concept.uri.humanize]=0 
    end
    vector
  end
  
  def self.categories_by_user(user,count=3)
    classifications = ClassificationRating.find_by_similar_doneByUser(user)
    res=[]
    classifications.each do |classification|
      res << {classification.similar_belongsToConcept.first.uri => classification.similar_hasRating.first.convert_from_xsd} if(classification.similar_belongsToConcept.first.uri.extract_namespace != "http://www.serena.com/classification.owl")
    end
    res.sort!{|x,y| y.values.first <=> x.values.first}
    User.ratings_to_users(res[0,count])
  end
  
  private
  
  def self.ratings_to_users(array)
    res = []
    array.each do |a|
      res << a.keys.first
    end
    res
  end
  
end