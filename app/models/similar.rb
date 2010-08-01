class Similar < ActiveRecord::Base
  def self.similar_users(user,count)
    users = User.find
    vectors = {}
    vector={}
    results = []
    users.each do |u|
      if(u == user)
         vector[user.uri] = User.calculate_interest_vector(u)   
      else
         vectors[u.uri] = User.calculate_interest_vector(u)
      end
    end
    v1 = vector.values.first
    vectors.each do |person,vec|
      results << {person => InterestCalculator.compare_vector(v1,vec)}
    end
    results.sort!{|x,y| y.values.first <=> x.values.first }
    results[0,count]
  end
  
  def self.products_by_users(users)
    users = User.ratings_to_users(users)
    Product.products_by_users(users)
  end
  
end
