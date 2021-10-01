require "command"

COMMANDS_LIST = <<EOS

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
    def execute()
        puts COMMANDS_LIST
    end
end

class Quit < Command
    def execute()
        raise "Quit"
    end
end