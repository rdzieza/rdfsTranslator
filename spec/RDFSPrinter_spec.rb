require 'spec_helper'

describe RDFSPrinter do

	describe "#new" do

		before :all do
			@printer = RDFSPrinter.new(nil, nil, nil, nil)
		end

		it "should create an instace of RDFSPrinter" do
			expect(@printer).to be_an_instance_of(RDFSPrinter)
		end

	end

	describe "#rdfs_subclasses" do
		before :each do
			@cat = SubclassRelation.new('animal', 'cat')
			@hamster = SubclassRelation.new('animal', 'hamster')
			@entity_array = [ @cat, @hamster ]
			@rdfs_to_match = "<rdfs:Class rdf:about=\"cat\">
		<rdfs:subClassOf rdf:resource=\"#animal\"/>
</rdfs:Class>
<rdfs:Class rdf:about=\"hamster\">
		<rdfs:subClassOf rdf:resource=\"#animal\"/>
</rdfs:Class>"
		end

		# it "should return all entities in a RDFS form" do
		# 	printer = RDFSPrinter.new(nil, @entity_array, nil, nil)
		# 	expect(printer.send(:rdfs_subclasses)).to match(@rdfs_to_match)
		# end
	end

# 	describe "#write_to_file" do
	  
# 		before :each do
# 			@file_name = 'test.rdf'
# 			RDFSPrinter.write_to_file(@file_name , nil, nil, nil)
# 		end

# 		it "should create a file \"test.rdf\"" do
# 			expect(File.exists?(@file_name)).to be true
# 		end

# 	end

end 