require "command"
require "commands/task"

RSpec.shared_examples "method definition" do |method|
    it "should have a method '#{method.to_s}' defined" do
        expect(described_class.method_defined? method).to eq(true)
    end
end

RSpec.describe CLI do
    it_behaves_like "method definition", :execute

    describe "#instance" do
        it "should not be nil" do
            expect(described_class.instance).to_not be_nil
        end

        it "is a class method which returns same instance" do
            expect(described_class.instance).not_to be_nil
        end
    end
end

RSpec.describe CommandFactory do
    subject(:factory) { CommandFactory }

    describe "#load_commands" do
        it "should load all the commands" do
            expect(subject.list_commands.size).to eq(0)
            subject.load_commands
            expect(subject.list_commands.size).to eq(8)
        end
    end

    describe "#list_commands" do
        it "returns the list of commands" do
            expect(subject.list_commands.size).to be > 0
        end
    end

    describe "#get_command" do
        it "returns the list of command registered (shouldn't be zero)" do
            expect(subject.get_command "lt").to_not be_nil
        end
    end
end

RSpec.describe ListTask do
    subject(:lt) { CommandFactory.get_command('lt') }
    it "should be belong to Command class" do
        expect(ListTask.superclass).to eq(Command)
    end

    describe "#name" do
        it "should be a string" do
            expect(lt.name).to be_a(String)
        end
    end

    describe "#execute" do
        it "should have a method which executes the command" do
            expect(lt.respond_to?(:execute)).to eq(true)
        end

        it "should list the tasks present in it" do
            lt.execute("detailed")
        end
    end
end
