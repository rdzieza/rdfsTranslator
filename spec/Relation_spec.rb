require 'spec_helper'

describe Relation do
  before :all do
  	@relation = Relation.new('teacher', 'works', 'school')
  end

  describe "#new" do
  	it "should create an instance of Property class" do
  		expect(@relation).to be_an_instance_of(Relation)
  	end
  end

  describe "#to_s" do
  	it "should print relation in singular form in a string format" do
  		expect(@relation.to_s).to match("teacher works school")
  	end
  end

end