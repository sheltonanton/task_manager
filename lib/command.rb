class CLI
    @object_instance = self.new
    private_class_method :new

    def self.instance
        return @object_instance
    end

    def execute
        command_string = gets
        command = CommandFactory.getCommand(command_string)
        raise "no such command" if !command.nil? && !command.is_a?(Command)
        command.execute()
    end
end

class CommandFactory
    private_class_method :new
    @hash = {}

    def self.registerCommand(commandClass)
        command = commandClass.new
        raise "Command name not found" if command.name == nil || command.cmd == nil
        if !@hash.has_key? command.cmd
            @hash[command.cmd] = command
        else
            existing = @hash[command.cmd]
            raise "Already existing command" if existing.class != command.class
        end
    end

    def self.getCommand(command_string)
        if @hash.has_key? command_string
            return @hash[command_string]
        end
        return nil
    end

    def self.listCommands()
        @hash.values
    end
end


class Command
    attr_reader :name, :cmd
    @name = "command"
    @cmd = nil
    def initialize(name, cmd)
        @name = name
        @cmd = cmd
    end

    def execute()
    end
end
