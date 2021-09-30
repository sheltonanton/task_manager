require "command"

class ListTaskGroup < Command
    def initialize()
        super("list group", "ltg")
    end

    def execute()
        # list down the task groups from taskGroupFactory
    end
end

class AddTaskGroup < Command
    def initialize()
        super("add group", "atg")
    end

    def execute()
        # add task group to the taskGroupFactory
    end
end

class RemoveTaskGroup < Command
    def initialize()
        super("remove group", "rtg")
    end

    def execute()
        # add task group to the taskGroupFactory
    end
end

class AddTaskGroupDependency < Command
    def initialize()
        super("add group dependency", "atgd")
    end

    def execute()
        # add task group dependency
    end
end

class RemoveTaskGroupDependency < Command
    def initialize()
        super("remove group dependency", "rtgd")
    end

    def execute()
        # remove task group dependency
    end
end

CommandFactory.registerCommand(ListTaskGroup)
CommandFactory.registerCommand(AddTaskGroup)
CommandFactory.registerCommand(RemoveTaskGroup)
CommandFactory.registerCommand(AddTaskGroupDependency)
CommandFactory.registerCommand(RemoveTaskGroupDependency)
