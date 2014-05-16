require_relative "app"
require "test/unit"

class TestApp < Test::Unit::TestCase
	def test_delete_meaningless_words
		array = delete_meaningless_words([ "Mateusz", "the", "a", "an", "in", "to", "at", "with"], [ "the", "a", "an", "in", "to", "at", "with"])
		assert_equal(1, array.count, "Has different amount of elements")
	end
end