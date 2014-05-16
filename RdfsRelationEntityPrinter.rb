require "./AbstractRdfsPrinter.rb"

class RdfsRelationEntityPrinter < AbstractRdfsPrinter
	
	def print_rdfs_entity(entity)
		return "<rdfs:Property rdf:about='##{entity.name}>
		<rdfs:domain rdf:about='##{entity.subject}'/>
		<rdfs:range rdf:about='##{entity.object}'/>
		</rdfs:Property>"
	end
end