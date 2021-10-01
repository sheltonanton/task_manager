require "command"

commandsList = <<EOS

Command list
------------
q - quit
at - add task
rt - remove task
lt - list tasks in no particular order
lto - list tasks in optimum order
atd - add task dependency
rtd - remove task dependency

EOS

class CmdList < Command
    def initialize
        super("command list", "cmd")
    end

    def execute()
        puts commandsList
    end
end

class Quit < Command
    def initialize()
        super("quit", "q")
    end

    def execute()
        raise "Quit"
    end
end


CommandFactory.registerCommand(Quit)