require "./AbstractRdfsPrinter.rb"

class RdfsClassEntityPrinter < AbstractRdfsPrinter
	
	def print_rdfs_entity(entity)
		return "<rdfs:Class rdf:about=\"#{entity}\"></rdfs:Class>\n"
	end
end