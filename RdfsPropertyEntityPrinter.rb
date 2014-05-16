require "./AbstractRdfsPrinter.rb"

class RdfsPropertyEntityPrinter < AbstractRdfsPrinter
	
	def print_rdfs_entity(entity)
		return "<rdfs:Property rdf:about='##{entity.object}'>\n
		\t<rdfs:domain rdf:about='##{entity.subject}'/>\n
		\t<rdfs:range rdf:about='&rdf;Literal'/>\n
		</rdfs:Property>\n"
	end
end