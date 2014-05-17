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

	def subject
		@subject
	end

	def name
		@name
	end

	def object
		@object
	end

end
