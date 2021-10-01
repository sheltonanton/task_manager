module Loader
    def Loader.load_commands(cf)

        require 'commands/task'
        require 'commands/basic'
    
        cf.register_command(Quit, "quit", "q")
        cf.register_command(CmdList, "cmd list", "cmd")
        cf.register_command(ListTask, "list task", "lt")
        cf.register_command(AddTask, "add task", "at")
        cf.register_command(RemoveTask, "remove task", "rt")
        cf.register_command(ListTaskOrdered, "list task ordered", "lto")
        cf.register_command(AddTaskDependency, "add task dependency", "atd")
        cf.register_command(RemoveTaskDependency, "remove task dependency", "rtd")
    end
end