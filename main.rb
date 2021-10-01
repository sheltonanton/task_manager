dirname = File.join(File.dirname(__FILE__), 'lib')
$LOAD_PATH.unshift(dirname) unless $LOAD_PATH.include?(dirname)

require "command"
require "task_group"

cli = CLI.instance
TaskGroupFactory.load "tg.dat"

begin
    while true
        begin
            puts "cmd for command list"
            cli.execute()
        rescue Exception => e
            break if e.message == 'Quit'
            puts e.message
        end
    end
rescue Exception => e
    puts "Program exited"
end