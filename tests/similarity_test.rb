require_relative '../lib/similarity.rb'
 require 'minitest/autorun'

  class TestSimilarity < Minitest::Test
    class MockObject
      attr_reader :attributes

      def initialize(attrs)
        @attributes = attrs
      end

      def self.column_names
        @column_names ||= []
      end

      def [](key)
        @attributes[key]
      end
    end

    def setup
      @similarity = Similarity.new
    end

    def test_perfect_similarity
      MockObject.column_names.replace(['a', 'b', 'c'])
      obj1 = MockObject.new({'a' => 1, 'b' => 2, 'c' => 3})
      obj2 = MockObject.new({'a' => 2, 'b' => 4, 'c' => 6})
      assert_in_delta 1.0, Similarity.similarity_of(obj1, obj2), 0.001
    end

    def test_no_similarity
      MockObject.column_names.replace(['a', 'b', 'c'])
      obj1 = MockObject.new({'a' => 1, 'b' => 2, 'c' => 3})
      obj2 = MockObject.new({'a' => 2, 'b' => 2, 'c' => 2})
      assert_in_delta 0.0, Similarity.similarity_of(obj1, obj2), 0.001
    end

    def test_perfect_dissimilarity
      MockObject.column_names.replace(['a', 'b', 'c'])
      obj1 = MockObject.new({'a' => 1, 'b' => 2, 'c' => 3})
      obj2 = MockObject.new({'a' => 3, 'b' => 2, 'c' => 1})
      assert_in_delta -1.0, Similarity.similarity_of(obj1, obj2), 0.001
    end

    def test_partial_similarity
      MockObject.column_names.replace(['a', 'b', 'c'])
      obj1 = MockObject.new({'a' => 1, 'b' => 2, 'c' => 3})
      obj2 = MockObject.new({'a' => 2, 'b' => 3, 'c' => 3})
      similarity = Similarity.similarity_of(obj1, obj2)
      assert similarity > 0 && similarity < 1, "Expected partial similarity, got #{similarity}"
    end

    def test_different_keys
      MockObject.column_names.replace(['a', 'b', 'c'])
      obj1 = MockObject.new({'a' => 1, 'b' => 2, 'c' => 3})
      MockObject.column_names.replace(['x', 'y', 'z'])
      obj2 = MockObject.new({'x' => 1, 'y' => 2, 'z' => 3})
      assert_equal 0, Similarity.similarity_of(obj1, obj2)
    end

    def test_empty_objects
      MockObject.column_names.clear
      obj1 = MockObject.new({})
      obj2 = MockObject.new({})
      assert_equal 0, Similarity.similarity_of(obj1, obj2)
    end
  end
