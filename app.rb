require "active_support/core_ext/string"
require "linguistics"
require "./Property.rb"
require "./Relation.rb"
require "./SubclassRelation.rb"
require "./RdfsSubclassRelationEntityPrinter.rb"
require "./RdfsRelationEntityPrinter.rb"
require "./RdfsPropertyEntityPrinter.rb"
require "./RdfsClassEntityPrinter.rb"
require "./ResultRdfsFileWriter.rb"

### Methods

# Method for deleting words from the array and returning array
def delete_meaningless_words(words_array, meaningless_array)
	words = Array.new()

	words_array.each do |word|
		if !meaningless_array.include?(word)
			words << word		#remove meaningless words
		end
	end

	return words
end

# Method for checking singularity of word
def is_singular?(string)
	Linguistics.use( :en )
	string.en.plural.singularize == string
end

meaningless = [ "the", "a", "an", "in", "to", "at", "with"]

content = File.open("content.txt", "r")

classes = Array.new
properties = Array.new
relations = Array.new
subclasses = Array.new

content.each do |line|
	line.tr!('.', "") #remove dot from the end of the sentence
	# puts line 
	words = line.split(" ").each{ |word| word.downcase!} #split into single words and downcase
	words = delete_meaningless_words(words, meaningless)

	if words.size == 3	#if is a triple

		subject = is_singular?(words[0]) ? words[0] : words[0].singularize
		if !classes.include?(subject)   #if class doesn't exist add one
 			classes << subject
		end

		verb = words[1]
		case verb
			when "is" then
				subclassRelation = SubclassRelation.new(words[2], words[0])
				subclasses << subclassRelation
				object = is_singular?(words[2]) ? words[2] : words[2].singularize
				if !classes.include?(object)   #if class doesnt exist add one
	 				classes << object
				end
			when "has" then
				property = Property.new(words[0], words[2])
				properties << property
			else
				relation = Relation.new(words[0], words[1], words[2])
				relations << relation
				object = is_singular?(words[2]) ? words[2] : words[2].singularize
				if !classes.include?(object)   #if class doesnt exist add one
	 				classes << object
				end
		end
	end


p classes
	
end
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