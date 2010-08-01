class Product < SemanticRecord::Base
  self.base = "http://www.serena.com/product_facts.owl#"
  self.uri="http://www.serena.com/product_facts.owl#Product"
  
  def self.products_by_users(users)
    categories = []
    results = []
    users.each do |user|
      categories << User.categories_by_user(user)
    end
    ranked = rank_categories(categories.flatten!)
    erg = products_by_categories(ranked)
  end
  
  def self.categories_by_products(products)
    categories = []
    q=""
    p = products.pop
    products.each do |product|
      q << "{<#{product.uri}> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?result.} UNION"
    end
    q << "{<#{p.uri}> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?result.}"
    query = "SELECT ?result WHERE {?result <http://www.w3.org/2000/01/rdf-schema#subClassOf> <http://www.serena.com/classification.owl#Concept>. #{q}}"
    categories = Classification.custom_by_sparql(query,"Classification")
    ranked = rank_categories_with_uri(categories)    
  end
  
  def self.products_by_categories(ranked)
      erg=[]
      i=5
      until ((erg.length >1)||(i<1))
        q=""
        ranked[0,i].each do |rank|
          q << "?result <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <#{rank[0]}>. "
      end
      query = "SELECT DISTINCT ?result WHERE {?result <http://www.serena.com/similar.owl#hasOverallRating> ?rating. #{q}} ORDER BY ?rating LIMIT 10"
      erg = SemanticRecord::Base.custom_by_sparql(query,"Product")
      i-=1
      end
      erg
  end

  def self.rank_categories(categories)
    res = {}
    categories.each do |cat|
      res[cat] ? res[cat]+=1 : res[cat]=1
    end
    res.to_a.sort!{|x,y| y[1] <=> x[1] }
  end
  
  def self.rank_categories_with_uri(categories)
    res = {}
    categories.each do |cat|
      res[cat.uri] ? res[cat.uri]+=1 : res[cat.uri]=1
    end
    res.to_a.sort!{|x,y| y[1] <=> x[1] }
  end
end