require "./AbstractRdfsPrinter.rb"

class RdfsPropertyEntityPrinter < AbstractRdfsPrinter
	
	def print_rdfs_entity(entity)
		return "<rdfs:Property rdf:about=\"##{entity.object}\">
		<rdfs:domain rdf:resource=\"##{entity.subject}\"/>
		<rdfs:range rdf:resource=\"&rdf;Literal\"/>\n</rdfs:Property>\n"
	end
end