require "./Property.rb"
require "./Relation.rb"
require "./SubclassRelation.rb"
require "./RdfsSubclassRelationEntityPrinter.rb"
require "./RdfsRelationEntityPrinter.rb"
require "./RdfsPropertyEntityPrinter.rb"


def print_simple_array(arr)
	arr.each do |el|
		print " " + el
	end
	puts ""
end

def print_complex_array(arr)
	arr.each do |el|
		print " " + el.to_s
	end
	puts ""
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
		when "has" then
			property = Property.new(words[0], words[2])
			properties << property
		else
			relation = Relation.new(words[0], words[1], words[2])
			relations << relation
		end

		object = words[2]
		if !classes.include?(object)   #if class doesnt exist add one
 			classes << object
		end
	end


	
}

printer = RdfsSubclassRelationEntityPrinter.new
subclasses.each do |entity|
	print printer.print_rdfs_entity(entity)
end

printer = RdfsRelationEntityPrinter.new
relations.each do |entity|
	print printer.print_rdfs_entity(entity)
end

printer = RdfsPropertyEntityPrinter.new
properties.each do |entity|
	print printer.print_rdfs_entity(entity)
end

=begin
	
puts "classes: "
print_simple_array(classes)
puts "relations: "
print_complex_array(relations)
puts "properties: "
print_complex_array(properties)
puts "subclasses: "
print_complex_array(subclasses)

=end