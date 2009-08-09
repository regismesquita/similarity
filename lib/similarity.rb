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


#Run Pearson Correlation algorithm  
def pearson_correlation(hash1,hash2)
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
