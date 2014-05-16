require "./Property.rb"
require "./Relation.rb"
require "./SubclassRelation.rb"
require "./RdfsSubclassRelationEntityPrinter.rb"
require "./RdfsRelationEntityPrinter.rb"
require "./RdfsPropertyEntityPrinter.rb"
require "./RdfsClassEntityPrinter.rb"
require "./ResultRdfsFileWriter.rb"


def to_lower_case!(arr)
	arr.each do |el|
		el.downcase!
	end
end

meaningless = [ "the", "a", "an", "in", "to", "at", "with"]

content = File.open("content.txt", "r")

classes = Array.new
properties = Array.new
relations = Array.new
subclasses = Array.new

content.each { |line|
	line.tr!('.', "") #remove .
	puts line 
	words = line.split(" ")	#split into single words
	words = to_lower_case!(words) #make all letters small

	words.each do |word|
		if meaningless.include?(word)
			words.delete(word)		#remove meaningless words
		end
	end

	if words.size == 3	#if is a triple
		
		subject = words[0]
		if !classes.include?(subject)   #if class doesnt exist add one
 			classes << subject
		end

		verb = words[1]
		case verb
		when "is" then
			subclassRelation = SubclassRelation.new(words[2], words[0])
			subclasses << subclassRelation
			object = words[2]
			if !classes.include?(object)   #if class doesnt exist add one
 				classes << object
			end
		when "has" then
			property = Property.new(words[0], words[2])
			properties << property
		else
			relation = Relation.new(words[0], words[1], words[2])
			relations << relation
			object = words[2]
			if !classes.include?(object)   #if class doesnt exist add one
 				classes << object
			end
		end

		
	end



	
}
content.close


subclases_outcome = String.new
clases_outcome = String.new
properties_outcome = String.new
relations_outcome = String.new

printer = RdfsSubclassRelationEntityPrinter.new
subclasses.each do |entity|
	subclases_outcome +=  printer.print_rdfs_entity(entity)
	classes.delete(entity.child)
end

printer = RdfsClassEntityPrinter.new
classes.each do |entity|
	clases_outcome += printer.print_rdfs_entity(entity)
end


printer = RdfsRelationEntityPrinter.new
relations.each do |entity|
	relations_outcome += printer.print_rdfs_entity(entity)
end

printer = RdfsPropertyEntityPrinter.new
properties.each do |entity|
	properties_outcome += printer.print_rdfs_entity(entity)
end

file_writer = ResultRdfsFileWriter.new
file_writer.write_result(clases_outcome, subclases_outcome, relations_outcome, properties_outcome)