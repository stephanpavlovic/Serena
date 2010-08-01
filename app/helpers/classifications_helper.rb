module ClassificationsHelper

  def string_to_object_helper(array)
    res = []
    array.each do |str|
      type = str.match("(integer|float|string|int)").to_s
      temp = case type
        when "integer" then str.match('.*"').to_s[1..(str.match('.*"').to_s.length)].to_i
        when "int" then str.match('.*"').to_s[1..(str.match('.*"').to_s.length)].to_i
        when "float" then str.match('.*"').to_s[1..(str.match('.*"').to_s.length)].to_f
      end
      res << temp
    end
     res
  end

end
