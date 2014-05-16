class SubclassRelation
	@parent
	@child

	def initialize(parent, child)
		@parent = parent
		@child = child
	end

	def to_s()
		return "[ " + @child + " is a " + @parent + " ]"
	end

end