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

        if tasks.size == 0
            puts 'No tasks found'
        end
    end
end

class AddTask < Command
    def execute()
        puts 'adding task'

        print "title: "
        title = gets

        print "description: "
        description = gets

        print 'priority (l,m,h): '
        priority = gets

        print 'difficultry (e,m,d): '
        difficulty = gets

        print 'deadline (in hours): '
        deadline = gets

        deadline.to_i
        start_time = Time.now

        print 'status (pending, ongoing, done): '
        status = gets

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

        puts '----------'
        puts 'task added'
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
