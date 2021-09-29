require "task_group"

RSpec.describe TaskGroupFactory do
    describe "#load" do
        it 'loads json string file into task group for creating task' do
            TaskGroupFactory.load('tg.dat')
        end
    end
end