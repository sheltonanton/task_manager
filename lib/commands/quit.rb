require "command"

class Quit < Command
    def initialize()
        super("quit", "q")
    end

    def execute()
        raise "Quit"
    end
end


CommandFactory.registerCommand(Quit)