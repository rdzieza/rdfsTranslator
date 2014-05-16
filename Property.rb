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

end