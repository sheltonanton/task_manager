dirname = File.join(File.dirname(__FILE__), 'lib')
$LOAD_PATH.unshift(dirname) unless $LOAD_PATH.include?(dirname)

require "command"
require "task_group"

cli = CLI.instance
CommandFactory.load_commands
TaskGroupFactory.load "tg.dat"

begin
    while true
        begin
            puts "------------------------"
            puts "cmd for command list"
            puts "------------------------"
            cli.execute()
        rescue SystemExit, Interrupt
            raise
        rescue Exception => e
            break if e.message == 'Quit'
            puts e.message
        end
    end
rescue Exception => e
    puts "Program exited"
end