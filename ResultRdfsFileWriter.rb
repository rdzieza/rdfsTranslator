class ResultRdfsFileWriter
	@file_header
	@file_footer 
	@file_name 

	def initialize
	@file_header = "<?xml version='1.0'?>
<!DOCTYPE rdf:RDF [<!ENTITY rdf \"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">]>
<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" 
		 xmlns:rdfs=\"http://www.w3.org/2000/01/rdf-schema#\">\n\n"
	@file_footer = "</rdf:RDF>"
	@file_name = "result.rdf"
	end

	def write_result(classes, subclasses, relations, properties)
		File.open( @file_name , "w+") {
			|file| 
			file.write(@file_header + classes + subclasses + relations + properties + @file_footer) 
			file.close
		}
	end

end