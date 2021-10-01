require "command"
require "task_group"

class ListTask < Command
    def execute(*args)
        arg = args[0]
        tasks = TaskGroupFactory.get_current.tasks
        if arg == 'detailed'
            tasks.each do |task|
                puts "(#{task.id}) #{task.title}"
                puts
                puts task.description
                puts '---------------'
            end
        else
            tasks.each do |task|
                puts "(#{task.id}) #{task.title}"
            end
        end
    end
end

class AddTask < Command
    def execute()
        puts 'adding task'
        title = gets 'title'
        description = gets 'description'
        priority = gets 'priority (l,m,h)'
        difficulty = gets 'difficultry (e,m,d)'
        deadline = gets 'deadline (in hours)'
        deadline.to_i
        start_time = Time.now
        status = gets 'status (pending, ongoing, done)'

        data = {
            "title" => title,
            "description" => description,
            "priority" => priority,
            "difficulty" => difficulty,
            "deadline" => deadline,
            "start_time" => start_time,
            "status" => status
        }
        tg = TaskGroupFactory.get_current
        tg.add_task(data)
    end
end

class RemoveTask < Command
    def execute()
        puts 'give task id:'
        id = gets 'task id'
        forced = gets 'force remove even when dependencies are there? (y/n)'

        forced = forced == 'y'
        TaskGroupFactory.get_current.remove_task(id, forced)
    end
end

class ListTaskOrdered < Command
    def execute()
        tg = TaskGroupFactory.get_current.sort
        sorted = tg.sort.reverse
        sorted.each do |task|
            puts "(#{task.id}) #{task.title}"
            puts
            puts task.description
            puts '---------------'
        end
    end
end

class AddTaskDependency < Command
    def execute()
        tg = TaskGroupFactory.get_current
        a = gets 'id of task which depends on'
        a = a.to_i
        b = gets 'id of task which the given one is depended on'
        b = b.to_i

        a = tg.get_task(a)
        b = tg.get_task(b)

        tg.add_dependency(a, b)
    end
end

class RemoveTaskDependency < Command
    def execute()
        tg = TaskGroupFactory.get_current
        a = gets 'id of task which depends on'
        a = a.to_i
        b = gets 'id of task which the given one is depended on'
        b = b.to_i

        a = tg.get_task(a)
        b = tg.get_task(b)

        tg.remove_dependency(a, b)
    end
end
