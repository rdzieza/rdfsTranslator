require 'spec_helper'

describe SubclassRelation  do
	before :all do
		@subclass_relation = SubclassRelation.new('animal', 'dog')
	end

	describe "#new" do
		it "should take two parameters and return SubclassRelation object" do
			expect(@subclass_relation).to be_an_instance_of(SubclassRelation)
		end
	end

	describe "#to_s" do
		it "should return the attributes" do
			expect(@subclass_relation.to_s).to match("dog inherits from animal")
		end
	end
end