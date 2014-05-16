require "./AbstractRdfsPrinter.rb"

class RdfsRelationEntityPrinter < AbstractRdfsPrinter
	
	def print_rdfs_entity(entity)
		return "<rdfs:Property rdf:about=\"##{entity.name}\">
		<rdfs:domain rdf:resource=\"##{entity.subject}\"/>
		<rdfs:range rdf:resource=\"##{entity.object}\"/>\n</rdfs:Property>\n"
	end
end