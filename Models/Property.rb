class Property
	
	attr_accessor :subject, :object

	def initialize(subject, object)
		@subject = subject
		@object = object
	end

	def to_s()
		return "#{subject} has #{object} property"
	end

end