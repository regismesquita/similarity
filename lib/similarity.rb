# frozen_string_literal: true
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


# Similarity Module
#
# This module uses the Pearson correlation coefficient to measure similarity
# between two objects (typically ActiveRecord instances).
#
# The coefficient ranges from -1 to +1, where:
#   1 indicates perfect similarity
#   0 indicates no similarity
#  -1 indicates perfect dissimilarity (inverse relationship)
#
# Examples in similarity context:
#   1 (Perfect Similarity): Objects have identical attribute patterns.
#      e.g., User1: {age: 25, posts: 10, karma: 100}
#            User2: {age: 30, posts: 12, karma: 120}
#      (All attributes scale proportionally)
#
#   0 (No Similarity): Objects have no discernible pattern in attributes.
#      e.g., User1: {age: 25, posts: 100, karma: 50}
#            User2: {age: 50, posts: 10, karma: 500}
#
#  -1 (Perfect Dissimilarity): Objects have inverse attribute patterns.
#      e.g., Product1: {price: 100, stock: 50, sales: 1000}
#            Product2: {price: 50, stock: 100, sales: 500}
#      (As one attribute increases, the other decreases proportionally)
#
# In practice, most similarities fall between these extreme values.
#
# Usage:
#   similarity = Similarity.similarity_of(object1, object2)

class Similarity
  def self.similarity_of(obj1,obj2)
    new.similarity_of(obj1, obj2)
  end

  # Convert ActiveRecord object to a hash
  def object_to_hash(ar_object)
    ar_object.attributes
  end

  # Calculate Pearson correlation coefficient between two hashes
  def pearson_correlation(hash1, hash2)
    # Find common keys between the two hashes
    shared_keys = hash1.keys & hash2.keys
    return 0 if shared_keys.empty?

    # Extract values for shared keys and convert to integers
    values1, values2 = shared_keys.map { |k| [hash1[k].to_i, hash2[k].to_i] }.transpose
    n = shared_keys.size

    # Calculate sums and squared sums
    sum1, sum2 = values1.sum, values2.sum
    sum_squares1 = values1.sum { |v| v**2 }
    sum_squares2 = values2.sum { |v| v**2 }
    
    # Calculate sum of products
    sum_products = values1.zip(values2).sum { |v1, v2| v1 * v2 }

    # Pearson correlation formula components
    numerator = sum_products - (sum1 * sum2 / n)
    denominator = Math.sqrt((sum_squares1 - sum1**2 / n) * (sum_squares2 - sum2**2 / n))

    # Avoid division by zero and return result
    denominator.zero? ? 0 : numerator / denominator
  end

  # Calculate similarity between two ActiveRecord objects
  def similarity_of(object1, object2)
    pearson_correlation(object_to_hash(object1), object_to_hash(object2))
  end
end

