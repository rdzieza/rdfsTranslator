require "active_support/core_ext/string"
require "linguistics"
require "./Models/Property.rb"
require "./Models/Relation.rb"
require "./Models/SubclassRelation.rb"
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

# Checks if provided class already exists and if not add it to the list
def add_rdfs_class(class_array, class_name)
	singular_name = is_singular?(class_name) ? class_name : class_name.singularize

	if !class_array.include?(singular_name)
		class_array << singular_name
	end
end

# Adds subclass
def add_rdfs_subclass(subclasses_array, elements)
	subclass_noun = is_singular?(elements[0]) ? elements[0] : elements[0].singularize
	class_noun = is_singular?(elements[2]) ? elements[2] : elements[2].singularize

	subclasses_array << SubclassRelation.new(class_noun, subclass_noun)
end

# Adds relation
def add_rdfs_relation(relations_array, elements)
	subclass_noun = is_singular?(elements[0]) ? elements[0] : elements[0].singularize
	class_noun = is_singular?(elements[2]) ? elements[2] : elements[2].singularize

	relations_array << Relation.new(subclass_noun, elements[1], class_noun)
end

# Adds property
def add_rdfs_property(properties_array, elements)
	properties_array << Property.new(elements[0], elements[2])
end


### Variables and const
MEANINGLESS = [ "the", "a", "an", "in", "to", "at", "with"]

content = File.open(ARGV[0], "r") # File with english sentences

classes = Array.new
properties = Array.new
relations = Array.new
subclasses = Array.new

### Main loop

content.each do |line|
	line.tr!('.', "") #remove dot from the end of the sentence
	words = line.split(" ").each{ |word| word.downcase!} #split into single words and downcase
	words = delete_meaningless_words(words, MEANINGLESS)

	if words.size == 3	#if is a triple

		add_rdfs_class(classes, words[0]) # add class

		verb = words[1]
		case verb
			when "is" then
				add_rdfs_subclass(subclasses, words)
				add_rdfs_class(classes, words[2])
			when "are" then
				add_rdfs_subclass(subclasses, words)
				add_rdfs_class(classes, words[2])
			when "has" then
				add_rdfs_property(properties, words)
				add_rdfs_class(classes, words[2])
			else
				add_rdfs_relation(relations, words)
				add_rdfs_class(classes, words[2])
		end
	end
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
file_writer.write_result(ARGV[1], clases_outcome, subclases_outcome, relations_outcome, properties_outcome)