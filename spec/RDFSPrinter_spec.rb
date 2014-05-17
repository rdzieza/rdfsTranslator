require 'spec_helper'

describe RDFSPrinter do
	describe "#print_rdfs_entity" do
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

		it "should return all entities in a RDFS form" do
			expect(RDFSPrinter.print_rdfs_entity(@entity_array)).to match(@rdfs_to_match)
		end
	end
end 