== Last Changes ==
09-Aug-2009 - 05:36 AM 
	-Added ar_object_to_hash(arObject) method
		This method is used to convert a ActiveRecord Object to a Hash.
	-Added similarity_of(arObject1,arObject2) method
		This method is used to get the similarity between 2 ActiveRecord objects returning a float where more similar it is more it gets close to 1.0 , and 1.0 means totally equal.
	-Changed pearson_correlation in order to filter non-integer values from the hash values.
	
09-Aug-2009 - 04:42 AM (First Method)
	-Added Pearson Correlation comparsion function receiving 2 hash lists as parameters.
		pearson_correlation(hash1,hash2)
---------
# Similarity Module

This module uses the **Pearson correlation coefficient** to measure similarity between two objects (typically ActiveRecord instances).

The coefficient ranges from -1 to +1, where:
- **1** indicates perfect similarity
- **0** indicates no similarity
- **-1** indicates perfect dissimilarity (inverse relationship)

## Examples in similarity context:

### 1 (Perfect Similarity)
Objects have identical attribute patterns.
\```
User1: {age: 25, posts: 10, karma: 100}
User2: {age: 30, posts: 12, karma: 120}
\```
(All attributes scale proportionally)

### 0 (No Similarity)
Objects have no discernible pattern in attributes.
\```
User1: {age: 25, posts: 100, karma: 50}
User2: {age: 50, posts: 10, karma: 500}
\```

### -1 (Perfect Dissimilarity)
Objects have inverse attribute patterns.
\```
Product1: {price: 100, stock: 50, sales: 1000}
Product2: {price: 50, stock: 100, sales: 500}
\```
(As one attribute increases, the other decreases proportionally)

In practice, most similarities fall between these extreme values.

## Usage
\```ruby
similarity = Similarity.similarity_of(object1, object2)
\```


This plugin is intended to provide methods and classes in order to make easy the similarity comparsion in rails between Models and objects.

This plugin is licensed under GPLv3 terms.

Author: Régis Mesquita <regis@regismesquita.com>
