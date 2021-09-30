require "command"

class ListTask < Command
    def initialize()
        super("list task", "lt")
    end

    def execute()
        # list down the task from taskGroup
    end
end

class AddTask < Command
    def initialize()
        super("add task", "at")
    end

    def execute()
        # add task to the taskGroup
    end
end

class RemoveTask < Command
    def initialize()
        super("remove task", "rt")
    end

    def execute()
        # add task to the taskGroup
    end
end

class ListTaskOrdered < Command
    def initilize()
        super("list task order"< "lto")
    end

    def execute()
        # list task in a given order
    end
end

class AddTaskDependency < Command
    def initialize()
        super("add task dependency", "atd")
    end

    def execute()
        # add task dependency
    end
end

class RemoveTaskDependency < Command
    def initialize()
        super("remove task dependency", "rtd")
    end

    def execute()
        # remove task dependency
    end
end

CommandFactory.registerCommand(ListTask)
CommandFactory.registerCommand(AddTask)
CommandFactory.registerCommand(RemoveTask)
CommandFactory.registerCommand(ListTaskOrdered)
CommandFactory.registerCommand(AddTaskDependency)
CommandFactory.registerCommand(RemoveTaskDependency)
