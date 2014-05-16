require "./AbstractRdfsPrinter.rb"

class RdfsRelationEntityPrinter < AbstractRdfsPrinter
	
	def print_rdfs_entity(entity)
		return "<rdfs:Property rdf:about='##{entity.name}'>\n
		\t<rdfs:domain rdf:about='##{entity.subject}'/>\n
		\t<rdfs:range rdf:about='##{entity.object}'/>\n
		</rdfs:Property>\n"
	end
end