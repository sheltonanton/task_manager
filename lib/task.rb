class Task
    attr_reader :title, :description
    def initialize(title, description=nil)
        @title = title
        @description = description
    end

    def set_description(description)
        @description = description
    end

    def set_title(title)
        @title = title
    end
end