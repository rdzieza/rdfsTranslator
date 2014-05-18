require 'spec_helper'

describe rdfst do

	describe "#delete_meaningless_words" do

		it "should delete given words from array" do
			array = delete_meaningless_words([ "Mateusz", "Zajac"], [ "Mateusz" ])
			expect(array.count).to equal(1)
		end

	end
  
end