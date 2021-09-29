require "task"
require "task_group"

RSpec.shared_examples "method definition check" do |method|
    it "should have a method '#{method.to_s}' defined" do
        expect(described_class.method_defined? method).to eq(true)
    end
end

RSpec.describe Task do
    subject(:task) { Task.new('Hello Task') }
    before(:example, :f => :subject_with_description) {
        # subject(:task) { Task.new('Hello Task', 'This is the description') }
    }

    it_behaves_like("method definition check", :title)

    describe "#title" do
        it "should be a string and equal to 'Hello Task'" do
            expect(task.title).to be_a String
            expect(task.title).to eq('Hello Task')
        end

        it_behaves_like("method definition check", :set_title)

        it "should replace the title in Task" do
            task.set_title "Changed title"
            expect(task.title).to eq("Changed title")
        end
    end

    it_behaves_like("method definition check", :description)

    describe "#description" do
        it "should have a description", :f => :subject_with_description do
            task = Task.new('Hello Task', 'This is the description')
            expect(task.description).to be_a(String)
            expect(task.description).to eq('This is the description')
        end

        it "shouldn't change the description" do
            expect {
                task.description "Yet another description"
            }.to raise_error(ArgumentError)
        end
    end

    it_behaves_like("method definition check", :set_description)

    it "should have a method name set_description" do
        expect(Task.method_defined? :set_description).to eq(true)
    end

    describe ".set_description" do
        it "should change the description" do
            expect(task.description.nil?).to eq(true)
            task.set_description "Yet another description"
            expect(task.description).to eq("Yet another description")
        end
    end
end





        

