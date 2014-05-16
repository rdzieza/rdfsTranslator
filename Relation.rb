class Relation
	@subject
	@name
	@object

	def initialize(subject, name, object)
		@subject = subject
		@name = name
		@object = object
	end

	def to_s()
		return "[ " + @subject + " " + @name + " " + @object + " ]"
	end

end
