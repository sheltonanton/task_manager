class TaskGroup
    attr_reader :name, :description
    def initialize(name, description=nil)
        @name = name
        @description = description
    end

    def set_description(description)
        @description = description
    end

    def set_name(name)
        @name = name
    end
end