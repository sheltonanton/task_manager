dirname = File.join(File.dirname(__FILE__), 'lib')
$LOAD_PATH.unshift(dirname) unless $LOAD_PATH.include?(dirname)

require "command"
require "task_group"

commandsList = <<EOS

Command list
------------
q - quit
atg - add taskgroup
at - add task
rtg - remove taskgroup
rt - remove task
ltg - list task groups
lt - list tasks in no particular order
lto - list tasks in optimum order

EOS

cli = CLI.instance
TaskGroupFactory.load "tg.dat"

begin
    while true
        puts commandsList
        cli.execute()
    end
rescue Exception => e
    puts "Program exited"
end