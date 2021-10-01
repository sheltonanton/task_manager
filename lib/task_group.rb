require "json"
require "task"

class TaskGroup
    attr_accessor :title, :description, :tasks, :dependencies, :id
    def initialize()
        @tasks = Array.new
        @dependencies = Hash.new
        @strategy = Strategy.new(@tasks, @dependencies)
    end

    def sort()
        @strategy.sort
    end

    def save()
        data = {
            "title" => @title,
            "description" => @description,
            "tasks" => @tasks.map { |task| task.save },
            "dependencies" => _save_dependencies,
            "id" => @id
        }

        return data
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

    def _save_dependencies
    end
end

class TaskGroupFactory
    private_class_method :new
    @@task_groups = Array.new
    @current = nil

    def self.listTaskGroups
        return @@task_groups
    end

    def self.load(file)
        file = File.open(file, "w+")
        
        begin
            json = JSON.parse(file.read())
            json.each do |record|
                tg = load_task_group(record)
                @@task_groups << tg
            end
            @current = (@task_groups.size > 0)? @task_groups[0]: _get_default
        rescue Exception => e
            puts "reading empty file"
        end
    end

    def _get_default
        tg = TaskGroup.new
        tg.id = 1
        tg.title = 'Default'
        @@task_groups << tg
        
        return tg
    end


    def self.save(file)
        save_this = @@task_groups.map { |tg| tg.save }
        file = File.open(file, "w+")

        begin
            dump = JSON.dump(save_this)
            file.write(dump)
        end
    end

    def self.get_current()
        if @@task_groups.size == 0
            @current = _get_default
        end
        return @current
    end

    def self.load_task_group(data)
        task_group = TaskGroup.new
        data.each { |attribute, value|
            task_group.send("#{attribute.to_s}=", value) if task_group.respond_to?(attribute.to_sym);
        }
        return task_group
    end
end
