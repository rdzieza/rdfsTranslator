require 'spec_helper'

describe Property do
	before :all do
		@property = Property.new('car', 'color')
	end

	describe "#new" do
		it "should return an object of Class Property" do
			expect(@property).to be_an_instance_of(Property)
		end
	end

	describe "#to_s" do
		it "should return attributes of object as a string" do
			expect(@property.to_s).to match("car has color property")
		end
	end
end