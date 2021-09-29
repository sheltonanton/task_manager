class CLI
    @instance = new
    def self.instance
        return @instance
    end

    def execute
        command = gets
    end
end


class Command
    def initialize(cmd)
        @cmd = cmd
    end

    def execute(args)
    end
end
