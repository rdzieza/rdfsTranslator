require "./AbstractRdfsPrinter.rb"

class RdfsSubclassRelationEntityPrinter < AbstractRdfsPrinter
	
	def print_rdfs_entity(entity)
		return "<rdfs:Class rdf:id='#{entity.child}'>
		<rdfs:subClassOf rdf:resource='##{entity.parent}'/>\n</rdfs:Class>\n"
	end
end