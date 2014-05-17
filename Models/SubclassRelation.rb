class SubclassRelation
	
	attr_accessor :parent, :child

	def initialize(parent, child)
		@parent = parent
		@child = child
	end

	def to_s()
		return "#{@child} inherits from #{@parent}"
	end

end