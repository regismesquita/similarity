#    This file is part of Similarity.
#
#    Similarity is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    Similarity is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with similarity.  If not, see <http://www.gnu.org/licenses/>.
class Similarity
  def self.similarity_of(obj1,obj2)
    new.similarity_of(obj1,obj2)
  end
  #Converts a Object to a hash
  def ar_object_to_hash(arObject)
  	returnedHash = Hash.new
  	arObject.class.column_names.each{|col| returnedHash.store(col,arObject[col])}
  	return returnedHash
  end
  
  #Run Pearson Correlation algorithm  
  def pearson_correlation(hash1,hash2)
	return 0 if hash1.empty? || hash2.empty?
  	#We are going to change some values so we're duping the variable for safety reasons.
  	hash1 = hash1.dup
  	hash2 = hash2.dup
  	#Loop in the hash eliminating any non-integer value.
  	hash1.each{|unit| hash1[unit[0]] = unit[1].to_i}
  	hash2.each{|unit| hash2[unit[0]] = unit[1].to_i}
  	
  	#Intersects keys so we have the same values in comparsion.
  	shared_keys = hash1.keys & hash2.keys
  	size = shared_keys.count
  	sum1 = hash1.values.reduce{|x,y| x+y}
  	sum2 = hash2.values.reduce{|x,y| x+y}
  	sum1square = hash1.values.map{|x| x**2}.reduce{|x,y| x+y}
  	sum2square = hash2.values.map{|x| x**2}.reduce{|x,y| x+y}
  	multi = shared_keys.map{|key| hash1[key]*hash2[key]}.reduce{|x,y| x+y}
  	num = multi-(sum1*sum2/size)
  	den = Math.sqrt((sum1square-(sum1**2)/size)*(sum2square-(sum2**2)/size))
  	if den == 0 then return 0 end
  	r = num/den
          return r
  end
  
  #Gets the similarity between 2 AR objects
  def similarity_of(arObject1,arObject2)
  		object = ar_object_to_hash(arObject1)
  		object2 = ar_object_to_hash(arObject2)
  		return pearson_correlation(object,object2)
  end
end
