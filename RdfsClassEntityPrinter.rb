require "./AbstractRdfsPrinter.rb"

class RdfsClassEntityPrinter < AbstractRdfsPrinter
	
	def print_rdfs_entity(entity)
		return "<rdfs:Class rdf:id='" + entity + "'></rdfs:Class>"
	end
end