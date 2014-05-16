require "./AbstractRdfsPrinter.rb"

class RdfsPropertyEntityPrinter < AbstractRdfsPrinter
	
	def print_rdfs_entity(entity)
		return "<rdfs:Property rdf:about='##{entity.object}'>
		<rdfs:domain rdf:about='##{entity.subject}'/>
		<rdfs:range rdf:about='&rdf;Literal'/>\n</rdfs:Property>\n"
	end
end