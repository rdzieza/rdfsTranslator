class RDFSPrinter

	attr_accessor :classes, :subclasses, :properties, :relations

	HEADER = "<?xml version='1.0'?>
<!DOCTYPE rdf:RDF [<!ENTITY rdf \"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">]>
<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" 
		 xmlns:rdfs=\"http://www.w3.org/2000/01/rdf-schema#\">\n\n"
	FOOTER = "</rdf:RDF>"

	def initialize(classes, subclasses, properties, relations)
		@properties = properties
		@relations = relations
		@subclasses = subclasses
		@classes = generate_proper_classes(classes, subclasses)
	end

	def write_to_file(filename)
		File.open(filename, 'w') do |file|
			file << HEADER
			file << insert_new_line_with_comment("Classes") << rdfs_classes
			file << insert_new_line_with_comment("Subclasses") << rdfs_subclasses 
			file << insert_new_line_with_comment("Relations") << rdfs_relations 
			file << insert_new_line_with_comment("Properties") << rdfs_properties
			file << "\n" << FOOTER
		end
	end

	private

		def insert_new_line_with_comment(comment)
			return "\n<!-- #{comment} -->\n\n"
		end

		def generate_proper_classes(classes, subclasses)
			proper_classes = classes

			subclasses.each do |entity|
				proper_classes.delete(entity.child)
			end

			return proper_classes
		end

		def rdfs_subclasses
			subclass_outcome = String.new

			@subclasses.each do |entity|
				subclass_outcome << "<rdfs:Class rdf:about=\"#{entity.child}\">
			<rdfs:subClassOf rdf:resource=\"##{entity.parent}\"/>\n</rdfs:Class>\n"
			end

			return subclass_outcome
		end

		def rdfs_classes
			classes_outcome = String.new

			@classes.each do |entity|
				classes_outcome << "<rdfs:Class rdf:about=\"#{entity}\"></rdfs:Class>\n"
			end

			return classes_outcome
		end

		def rdfs_relations
			relations_outcome = String.new

			@relations.each do |entity|
				relations_outcome << "<rdfs:Property rdf:about=\"##{entity.name}\">
		<rdfs:domain rdf:resource=\"##{entity.subject}\"/>
		<rdfs:range rdf:resource=\"##{entity.object}\"/>\n</rdfs:Property>\n"
			end

			return relations_outcome
		end

		def rdfs_properties
			properties_outcome = String.new

			@properties.each do |entity|
				properties_outcome << "<rdfs:Property rdf:about=\"##{entity.object}\">
		<rdfs:domain rdf:resource=\"##{entity.subject}\"/>
		<rdfs:range rdf:resource=\"&rdf;Literal\"/>\n</rdfs:Property>\n"
			end

			return properties_outcome
		end

end