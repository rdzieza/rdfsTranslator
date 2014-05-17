class RDFSPrinter

	def self.print_rdfs_entity(entities)
		subclass_outcome = String.new

		entities.each do |entity|
			subclass_outcome << "<rdfs:Class rdf:about=\"#{entity.child}\">
		<rdfs:subClassOf rdf:resource=\"##{entity.parent}\"/>\n</rdfs:Class>\n"
		end

		return subclass_outcome
	end

end