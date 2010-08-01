module  SimilarityMethods
  def self.euklid(v1,v2)
    v3=v1-v2
    1-v3.r
  end
  
  def self.cosinus(v1,v2)
    numerator = v1.inner_product(v2)
    denominator = (v1.r) * (v2.r)
    
    numerator / denominator
  end
end