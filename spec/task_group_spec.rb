require "task_group"

RSpec.describe TaskGroupFactory do
    describe "#load" do
        it 'loads json string file into task group for creating task' do
            TaskGroupFactory.load('tg.dat')
        end
    end

    describe "#current" do
        it "should return a default task group if empty" do
            expect(TaskGroupFactory.get_current).to be_a(Task)
        end
    end
end

RSpec.describe TaskGroup do
    describe "#tasks" do
        it "is an array" do
            expect(subject.tasks).to be_a(Array)
        end
    end
    describe "#dependencies" do
        it "is a hash" do
            expect(subject.dependencies).to be_a(Hash)
        end
    end

    describe "._add_details" do
        it "should add details to the assigned task" do
            task = Task.new
            data = {
                :title => "hello task",
                "description" => "task description",
                "no_method" => "no_method"
            }
            expect {
                subject._add_details(task, data)
            }.to_not raise_error(Exception)
            
            expect(task.description).to eq(data['description'])
            expect(task.title).to eq(data[:title])
            expect {
                task.no_method
            }.to raise_error(NoMethodError)
        end
    end

    describe ".add_task" do
        it "should add a task to @tasks attribute and return the task" do
            data = {
                :title => "task 1",
                :description => "task description",
                :priority => "h",
                :difficulty => "l",
                :deadline => 2,
                :start_time => Time.now,
                :status => :pending
            }
            expect {
                task = subject.add_task(data)
                expect(task).to be_a(Task)
                data.each do |key, value|
                    expect(task.send key.to_s).to eq(value)
                end
                expect(task.id).to eq(1)
            }.to change{ subject.tasks.size }.from(0).to(1)
        end
    end

    describe "._get_id" do
        it "should return 1 if there isn't any task else return greater_id + 1" do
            expect(subject.tasks.size).to eq(0)
            expect(subject._get_id).to eq(1) #where there isn't any task, task id starts from 1
            3.times { subject.add_task({}) }
            task = subject.add_task({})
            expect(task.id).to eq(4)
        end
    end
end