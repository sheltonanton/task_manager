require "command"
require "commands/task_group"

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
    describe "#listCommands" do
        it "returns the list of commands" do
            expect(subject.listCommands.size).to be > 0
        end
    end

    describe "#getCommand" do
        it "returns the list of command registered (shouldn't be zero)" do
            expect(subject.getCommand "ltg").to_not be_nil
        end
    end
end

RSpec.describe ListTaskGroup do
    it "should be belong to Command class" do
        expect(ListTaskGroup.superclass).to eq(Command)
    end

    describe "#name" do
        it "should be a string" do
            expect(subject.name).to be_a(String)
        end
    end
end
