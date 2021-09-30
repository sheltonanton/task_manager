require "json"
require "task"

class TaskGroup
    attr_reader :title, :description, :tasks, :dependencies
    def initialize()
        @tasks = Array.new
        @dependencies = Hash.new
        @strategy = Strategy.new(@tasks, @dependencies)
    end

    def get_task(id)
        return @strategy.get_vertex(id)
    end

    def add_task(task_data)
        task = Task.new
        task.id = _get_id()
        _add_details(task, task_data)
        @strategy.add_vertex(task)
        return task
    end

    def remove_task(id, forced=false)
        case @strategy.remove_vertex(id, forced)
        when :dependants_in_vertex 
            raise 'Task has dependants'
        end
    end

    def add_dependency(a, b)
        case @strategy.add_edge(a, b)
        when :already_added 
            raise 'Dependency already established'
        when :has_cycle 
            raise 'It forms a cyclic dependency when added'
        end
    end

    def remove_dependency(a, b)
        @strategy.remove_edge(a, b)
    end

    def _add_details(task, data)
        data.each { |attribute, value|
            task.send("#{attribute.to_s}=", value) if task.respond_to?(attribute.to_sym);
        }
    end

    def _get_id
        greater_task_id = @tasks.map { |task| task.id }.select {|id| id != nil }.inject do |max, id|
            [max, id].max
        end
        if greater_task_id == nil
            return 1
        else
            return greater_task_id + 1
        end
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
