class Property
	@subject
	@object

	def initialize(subject, object)
		@subject = subject
		@object = object
	end

	def to_s()
		return "[ " + @subject + " has a " + @object + " ]"
	end

	def subject
		@subject
	end

	def object
		@object
	end

end