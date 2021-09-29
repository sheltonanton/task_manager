require "json"

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

class TaskGroupFactory
    private_class_method :new
    @@task_groups = Array.new

    def self.listTaskGroups
        return @@task_groups
    end

    def self.load(file)
        file = File.open(file, "w+")
        
        begin
            json = JSON.parse(file.read())
            json.each do |record|
                load_task_group(record)
            end
        rescue Exception => e
            puts "reading empty file"
        end
    end

    def load_task_group(data)
        return
    end
end
